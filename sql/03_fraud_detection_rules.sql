-- =====================================================
-- Project: Procurement Fraud & Supplier Risk Data Pipeline
-- File: 03_fraud_detection_rules.sql
-- Purpose: Create fraud and supplier risk flags for each invoice
-- =====================================================

-- Drop old risk flag table if it already exists.
-- This lets us rerun the script without table-exists errors.
DROP TABLE IF EXISTS analytics.invoice_risk_flags;

-- Create invoice-level risk flag table.
-- Each invoice gets fraud/risk indicators.
CREATE TABLE analytics.invoice_risk_flags AS
SELECT
    invoice_id,
    supplier_id,
    supplier_name,
    department,
    invoice_date,
    due_date,
    payment_date,
    invoice_amount,
    currency,
    purchase_order_id,
    approval_status,
    supplier_risk_rating,
    supplier_country,

    -- Rule 1: High-value invoice
    -- Any invoice equal to or above £10,000 is flagged.
    CASE
        WHEN invoice_amount >= 10000 THEN 1
        ELSE 0
    END AS high_value_invoice_flag,

    -- Rule 2: Missing purchase order
    -- Invoices without PO references may create audit risk.
    CASE
        WHEN purchase_order_id IS NULL THEN 1
        ELSE 0
    END AS missing_po_flag,

    -- Rule 3: Late payment
    -- Payment date after due date means invoice was paid late.
    CASE
        WHEN payment_date > due_date THEN 1
        ELSE 0
    END AS late_payment_flag,

    -- Rule 4: Approval risk
    -- Pending, Missing, or Rejected approvals are risky.
    CASE
        WHEN approval_status IN ('Pending', 'Missing', 'Rejected') THEN 1
        ELSE 0
    END AS approval_risk_flag,

    -- Rule 5: High-risk supplier
    -- Suppliers rated High or Critical are flagged.
    CASE
        WHEN supplier_risk_rating IN ('High', 'Critical') THEN 1
        ELSE 0
    END AS high_risk_supplier_flag,

    -- Total invoice risk score
    -- This adds all risk flags together.
    (
        CASE WHEN invoice_amount >= 10000 THEN 1 ELSE 0 END
        +
        CASE WHEN purchase_order_id IS NULL THEN 1 ELSE 0 END
        +
        CASE WHEN payment_date > due_date THEN 1 ELSE 0 END
        +
        CASE WHEN approval_status IN ('Pending', 'Missing', 'Rejected') THEN 1 ELSE 0 END
        +
        CASE WHEN supplier_risk_rating IN ('High', 'Critical') THEN 1 ELSE 0 END
    ) AS invoice_risk_score

FROM staging.procurement_invoices_clean;