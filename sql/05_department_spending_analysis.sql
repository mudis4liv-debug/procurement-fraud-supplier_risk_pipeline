-- =====================================================
-- Project: Procurement Fraud & Supplier Risk Data Pipeline
-- File: 05_department_spending_analysis.sql
-- Purpose: Analyse procurement spend and risk by department
-- =====================================================

DROP TABLE IF EXISTS analytics.department_spend_summary;

CREATE TABLE analytics.department_spend_summary AS

SELECT
    department,

    COUNT(*) AS total_invoices,

    SUM(invoice_amount) AS total_spend,

    ROUND(AVG(invoice_amount), 2) AS average_invoice_value,

    SUM(high_value_invoice_flag) AS high_value_invoice_count,

    SUM(missing_po_flag) AS missing_po_count,

    SUM(late_payment_flag) AS late_payment_count,

    SUM(approval_risk_flag) AS approval_risk_count,

    SUM(high_risk_supplier_flag) AS high_risk_supplier_count,

    SUM(invoice_risk_score) AS total_department_risk_score

FROM analytics.invoice_risk_flags

GROUP BY department;