import json
import psycopg2

# Read JSON file
with open("data/procurement_invoices_dirty.json", "r") as file:
    invoices = json.load(file)

# Connect to PostgreSQL
conn = psycopg2.connect(
    host="localhost",
    database="procurement_fraud_supplier_risk_pipeline",
    user="postgres",
    password="@Iron86$",
    port="5432"
)

cursor = conn.cursor()

# Insert JSON records into PostgreSQL
for invoice in invoices:
    cursor.execute("""
        INSERT INTO raw.procurement_invoices (
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
            supplier_country
        )
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON CONFLICT (invoice_id) DO NOTHING;
    """, (
        invoice.get("invoice_id"),
        invoice.get("supplier_id"),
        invoice.get("supplier_name"),
        invoice.get("department"),
        invoice.get("invoice_date"),
        invoice.get("due_date"),
        invoice.get("payment_date"),
        invoice.get("invoice_amount"),
        invoice.get("currency"),
        invoice.get("purchase_order_id"),
        invoice.get("approval_status"),
        invoice.get("supplier_risk_rating"),
        invoice.get("country")
    ))

conn.commit()
cursor.close()
conn.close()
print("Procurement JSON data loaded successfully.")