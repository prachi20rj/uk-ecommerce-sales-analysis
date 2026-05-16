SELECT
    TO_CHAR(invoice_date, 'Day')       AS day_of_week,
    EXTRACT(HOUR FROM invoice_date)    AS hour,
    COUNT(DISTINCT invoice_no)         AS orders
FROM retail
GROUP BY 1, 2
ORDER BY orders DESC;