-- =====================================================
-- Project: Procurement Fraud & Supplier Risk Data Pipeline
-- File: 04_supplier_risk_summary.sql
-- Purpose: Create supplier-level risk summary
-- =====================================================

DROP TABLE IF EXISTS analytics.supplier_risk_summary;

CREATE TABLE analytics.supplier_risk_summary AS

SELECT

    supplier_id,
    supplier_name,
    supplier_country,

    COUNT(*) AS total_invoices,

    SUM(invoice_amount) AS total_invoice_value,

    AVG(invoice_amount) AS average_invoice_value,

    SUM(high_value_invoice_flag) AS high_value_invoices,

    SUM(missing_po_flag) AS missing_po_invoices,

    SUM(late_payment_flag) AS late_payment_invoices,

    SUM(approval_risk_flag) AS approval_risk_invoices,

    SUM(high_risk_supplier_flag) AS supplier_risk_flags,

    SUM(invoice_risk_score) AS total_risk_score

FROM analytics.invoice_risk_flags

GROUP BY

    supplier_id,
    supplier_name,
    supplier_country;