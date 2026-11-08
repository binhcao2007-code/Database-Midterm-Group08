# D1
CREATE VIEW v_detail AS
SELECT t.trip_id, t.departure_date, t.status, c.full_name AS customer_name, g.full_name AS guide_name, rg.name AS region_name, r.fee
FROM trips t
	JOIN customers c ON c.customer_id = t.customer_id
    JOIN guides g ON g.guide_id = t.guide_id
    JOIN regions rg ON rg.region_id = g.region_id
    LEFT JOIN trip_reports r ON r.trip_id = t.trip_id;
# check
SELECT * FROM v_detail ORDER BY trip_id;

# D2
CREATE VIEW v_group_summary AS
SELECT rg.region_id, rg.name AS region_name, COUNT(t.trip_id) AS total_trips,
		COALESCE(SUM(CASE WHEN t.status = 'Completed' THEN 1 ELSE 0 END), 0) AS completed_trips,
		COALESCE(SUM(CASE WHEN t.status = 'Cancelled' THEN 1 ELSE 0 END), 0) AS cancelled_trips,
		COALESCE(SUM(r.fee), 0) AS total_fee
FROM regions rg
	LEFT JOIN guides g ON g.region_id = rg.region_id
    LEFT JOIN trips t ON t.guide_id = g.guide_id
    LEFT JOIN trip_reports r ON r.trip_id = t.trip_id
GROUP BY rg.region_id, rg.name;
#check
SELECT * FROM v_group_summary ORDER BY region_id;

# D3
CREATE OR REPLACE VIEW v_debt AS
SELECT c.customer_id, c.full_name AS customer_name,
       COALESCE(f.total_fee, 0) AS total_fee,
       COALESCE(pd.total_paid, 0) AS total_paid,
       COALESCE(f.total_fee, 0) - COALESCE(pd.total_paid, 0) AS debt
FROM customers c
    LEFT JOIN (
        SELECT t.customer_id, SUM(r.fee) AS total_fee
        FROM trips t
            JOIN trip_reports r ON r.trip_id = t.trip_id
        GROUP BY t.customer_id
    ) f ON c.customer_id = f.customer_id
    LEFT JOIN (
        SELECT t.customer_id, SUM(p.amount) AS total_paid
        FROM trips t
            JOIN payments p ON p.trip_id = t.trip_id
        GROUP BY t.customer_id
    ) pd ON pd.customer_id = c.customer_id;
#check
SELECT * FROM v_debt ORDER BY customer_id;