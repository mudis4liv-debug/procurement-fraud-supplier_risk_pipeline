-- Create schemas
CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS analytics;

-- Drop old table if rerunning project
DROP TABLE IF EXISTS raw.procurement_invoices;

-- Create raw procurement invoice table
CREATE TABLE raw.procurement_invoices (
    invoice_id TEXT PRIMARY KEY,
    supplier_id TEXT,
    supplier_name TEXT,
    department TEXT,
    invoice_date DATE,
    due_date DATE,
    payment_date DATE,
    invoice_amount NUMERIC(12,2),
    currency TEXT,
    purchase_order_id TEXT,
    approval_status TEXT,
    supplier_risk_rating TEXT,
    supplier_country TEXT
);