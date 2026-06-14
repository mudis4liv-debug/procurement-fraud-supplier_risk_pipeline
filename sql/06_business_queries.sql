-- =====================================================
-- Project: Procurement Fraud & Supplier Risk Data Pipeline
-- File: 06_business_queries.sql
-- Purpose: Final business analysis queries for reporting and Power BI
-- =====================================================

-- 1. Total procurement spend
SELECT
    SUM(invoice_amount) AS total_procurement_spend
FROM staging.procurement_invoices_clean;


-- 2. Total number of invoices
SELECT
    COUNT(*) AS total_invoices
FROM staging.procurement_invoices_clean;


-- 3. Highest risk invoices
SELECT
    invoice_id,
    supplier_name,
    department,
    invoice_amount,
    approval_status,
    supplier_risk_rating,
    invoice_risk_score
FROM analytics.invoice_risk_flags
ORDER BY invoice_risk_score DESC, invoice_amount DESC;


-- 4. Highest risk suppliers
SELECT
    supplier_id,
    supplier_name,
    supplier_country,
    total_invoices,
    total_invoice_value,
    total_risk_score
FROM analytics.supplier_risk_summary
ORDER BY total_risk_score DESC, total_invoice_value DESC;


-- 5. Spend by department
SELECT
    department,
    total_invoices,
    total_spend,
    total_department_risk_score
FROM analytics.department_spend_summary
ORDER BY total_spend DESC;


-- 6. Missing purchase order invoices
SELECT
    invoice_id,
    supplier_name,
    department,
    invoice_amount,
    purchase_order_id
FROM analytics.invoice_risk_flags
WHERE missing_po_flag = 1;


-- 7. Late payment invoices
SELECT
    invoice_id,
    supplier_name,
    due_date,
    payment_date,
    invoice_amount
FROM analytics.invoice_risk_flags
WHERE late_payment_flag = 1;


-- 8. High-value invoices
SELECT
    invoice_id,
    supplier_name,
    department,
    invoice_amount,
    supplier_risk_rating
FROM analytics.invoice_risk_flags
WHERE high_value_invoice_flag = 1
ORDER BY invoice_amount DESC;


-- 9. Approval risk invoices
SELECT
    invoice_id,
    supplier_name,
    approval_status,
    invoice_amount
FROM analytics.invoice_risk_flags
WHERE approval_risk_flag = 1;


-- 10. Overall risk KPI summary
SELECT
    COUNT(*) AS total_invoices,
    SUM(invoice_amount) AS total_spend,
    SUM(high_value_invoice_flag) AS high_value_invoice_count,
    SUM(missing_po_flag) AS missing_po_count,
    SUM(late_payment_flag) AS late_payment_count,
    SUM(approval_risk_flag) AS approval_risk_count,
    SUM(high_risk_supplier_flag) AS high_risk_supplier_count,
    SUM(invoice_risk_score) AS total_risk_score
FROM analytics.invoice_risk_flags;