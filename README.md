# Procurement Fraud & Supplier Risk Analytics Pipeline

## Overview

This project demonstrates an end-to-end procurement fraud detection and supplier risk analytics pipeline developed using PostgreSQL, Python, JSON, SQL, and Power BI.

The solution simulates a real-world procurement environment where invoice transactions are ingested, validated, transformed, and analyzed to identify potential fraud indicators, supplier risks, and spending anomalies.

The project follows a layered analytics architecture consisting of Raw, Staging, and Analytics zones commonly used in modern data platforms and enterprise data warehouses.

## Business Problem

Procurement teams process large volumes of supplier invoices across multiple departments.

Without adequate controls, organizations face challenges such as:

* High-risk suppliers
* Unusually large invoice values
* Missing purchase orders
* Late supplier payments
* Approval process violations
* Inconsistent supplier master data

These issues increase operational risk, financial losses, and audit exposure.

The objective of this project is to identify these risks proactively and provide decision-makers with actionable procurement intelligence.

## Project Objectives

This project was designed to:

* Build an end-to-end analytics pipeline using PostgreSQL and Python.
* Load and process procurement invoice data from JSON files.
* Implement business rules for fraud detection.
* Measure supplier risk exposure.
* Analyze departmental spending patterns.
* Create an executive Power BI dashboard for decision support.

## Technology Stack

### Database
* PostgreSQL 17
* pgAdmin 4

### Programming & ETL
* Python
* Psycopg2

### Data Format
* JSON

### Business Intelligence
* Power BI Desktop
  
### Version Control
* Git
* GitHub

## Solution Architecture

Source JSON Dataset
↓
Python ETL Process
↓
Raw Schema
↓
Staging Schema
↓
Analytics Schema
↓
Business Analysis Queries
↓
Power BI Dashboard
↓
Business Insights & Recommendations

## Dataset

The procurement dataset contains supplier invoice transactions including:

| Field           | Description              |
| --------------- | ------------------------ |
| invoice_id      | Unique invoice reference |
| supplier_name   | Supplier name            |
| department      | Purchasing department    |
| invoice_amount  | Invoice value            |
| invoice_date    | Invoice date             |
| due_date        | Payment due date         |
| payment_date    | Actual payment date      |
| approval_status | Approval workflow status |
| purchase_order  | Purchase order reference |

## Data Pipeline Design

### Raw Layer
Stores source data exactly as received from the JSON file.

### Staging Layer
Performs:
* Data cleansing
* Standardization
* Data validation
* Quality checks

### Analytics Layer
Creates reporting-ready datasets used by Power BI and business stakeholders.

## Fraud Detection Framework
The following business rules were implemented:

### High-Risk Supplier Flag
Identifies suppliers previously classified as high risk.

### High-Value Invoice Flag
Flags invoices above the defined spending threshold.

### Missing Purchase Order Flag
Detects invoices submitted without a valid purchase order.

### Late Payment Flag
Identifies payments made after the agreed due date.

### Approval Risk Flag
Detects invoices that bypass expected approval controls.

### Invoice Risk Score
Generates an overall risk score based on multiple fraud indicators.

## Business Analysis Performed

### Department Spend Analysis
Measures total expenditure by department to identify areas of high procurement activity.

### Supplier Risk Analysis
Ranks suppliers according to cumulative risk exposure.

### Top Risky Invoices
Highlights transactions requiring immediate review by procurement and audit teams.

### KPI Monitoring
The dashboard tracks:
* Total Spend
* Total Invoices
* High-Risk Suppliers
* High-Value Invoices

## Dashboard Features
The Power BI dashboard provides:

### Executive KPI Cards
* Total Spend (£132.98K)
* Total Invoices (10)
* High-Risk Suppliers (3)
* High-Value Invoices (3)

### Interactive Visualizations
* Department Spend Analysis
* Supplier Risk Analysis
* Top Risky Invoices
* Invoice Risk Detail Table
* Department Filter

## Key Findings

### Procurement Department Generated the Highest Spend
The Procurement department recorded the highest invoice value, indicating the largest concentration of supplier expenditure.

### Supplier Risk Concentration Exists
Three suppliers accounted for the highest cumulative risk scores and should be prioritized for supplier due diligence.

### Multiple High-Risk Invoices Were Identified
Several invoices triggered multiple fraud indicators simultaneously, increasing their likelihood of requiring investigation.

### Supplier Data Quality Issues Were Detected
Supplier naming inconsistencies highlighted the importance of master data governance and supplier standardization.

## Recommendations

### Immediate Actions
* Review suppliers with elevated risk scores.
* Investigate invoices with multiple fraud indicators.
* Enforce purchase order compliance.
* Strengthen invoice approval controls.

### Medium-Term Improvements
* Introduce automated risk alerts.
* Improve supplier master data quality.
* Implement periodic supplier risk reviews.

### Long-Term Enhancements
* Integrate external supplier risk ratings.
* Build real-time monitoring pipelines.
* Deploy machine learning anomaly detection models.

## Repository Structure
```text
procurement-fraud-supplier_risk_pipeline/

├── data/
│   └── procurement_invoices_dirty.json

├── python/
│   └── load_procurement_json.py

├── sql/
│   ├── 01_create_schemas.sql
│   ├── 02_create_tables.sql
│   ├── 03_load_data.sql
│   ├── 04_data_cleaning.sql
│   ├── 05_risk_flags.sql
│   └── 06_business_queries.sql

├── powerbi/
│   └── procurement_fraud_supplier_risk_dashboard.pbix

├── reports/
│   ├── Procurement_Fraud_Supplier_Risk_Project_Report.docx
│   └── Procurement_Fraud_Supplier_Risk_SQL_Appendix.docx

├── screenshots/

└── README.md
```

## Skills Demonstrated
* SQL Development
* PostgreSQL Database Design
* Data Cleaning & Transformation
* Python ETL Development
* JSON Processing
* Fraud Analytics
* Risk Scoring
* Data Modelling
* Power BI Dashboard Development
* Business Intelligence Reporting
* GitHub Project Documentation

## Future Roadmap
Future enhancements may include:
* Azure Data Factory Integration
* Azure SQL Database
* Azure Data Lake Storage
* Databricks Processing
* Automated ETL Scheduling
* Machine Learning Fraud Detection
* Real-Time Risk Monitoring

## Author
### Mudiaga Umukoro
Data Analyst | Business Intelligence Analyst | Aspiring Data Engineer

This project forms part of my portfolio demonstrating SQL, PostgreSQL, Python ETL, Power BI, and analytical problem-solving skills for data analytics and data engineering roles.
