-- =====================================================
-- Project: Procurement Fraud & Supplier Risk Data Pipeline
-- File: 02_clean_staging_data.sql
-- Purpose: Clean raw procurement invoice data into staging table
-- =====================================================

-- Drop the old cleaned table if it already exists.
-- This allows us to rerun the script without errors.
DROP TABLE IF EXISTS staging.procurement_invoices_clean;

-- Create a cleaned staging table from the raw invoice data.
CREATE TABLE staging.procurement_invoices_clean AS
SELECT
    invoice_id,

    -- Remove spaces around supplier ID.
    TRIM(supplier_id) AS supplier_id,

    -- Standardise supplier name.
    -- Example: 'alpha medical ltd ' becomes 'Alpha Medical Ltd'
    INITCAP(TRIM(supplier_name)) AS supplier_name,

    -- Standardise department name.
    -- Example: 'procurement ' becomes 'Procurement'
    INITCAP(TRIM(department)) AS department,

    invoice_date,
    due_date,
    payment_date,

    invoice_amount,

    -- Standardise currency to uppercase.
    -- Example: 'gbp' becomes 'GBP'
    UPPER(TRIM(currency)) AS currency,

    -- Convert empty purchase order IDs into NULL.
    -- This makes missing values easier to detect later.
    NULLIF(TRIM(purchase_order_id), '') AS purchase_order_id,

    -- Standardise approval status.
    -- Example: 'APPROVED' becomes 'Approved'
    INITCAP(TRIM(approval_status)) AS approval_status,

    -- Standardise supplier risk rating.
    -- Example: 'low' becomes 'Low'
    INITCAP(TRIM(supplier_risk_rating)) AS supplier_risk_rating,

    -- Standardise country names.
    -- Example: 'UK' and 'England' become 'United Kingdom'
    CASE
        WHEN LOWER(TRIM(supplier_country)) IN ('uk', 'england', 'united kingdom')
            THEN 'United Kingdom'
        ELSE INITCAP(TRIM(supplier_country))
    END AS supplier_country

FROM raw.procurement_invoices;