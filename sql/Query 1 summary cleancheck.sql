SELECT
    COUNT(*)                        AS total_rows,
    MIN(invoice_date)               AS earliest_date,
    MAX(invoice_date)               AS latest_date,
    COUNT(DISTINCT customer_id)     AS unique_customers,
    COUNT(DISTINCT country)         AS countries
FROM retail;