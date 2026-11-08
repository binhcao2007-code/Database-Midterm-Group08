# 1. Liệt kê các chuyến tham quan Completed trong tháng 01/2025, kèm khách đại diện, hướng dẫn viên và ngày nghiệp vụ departure_date.

USE tour_guide_mini;

SELECT t.trip_id, t.departure_date, c.customer_id, c.full_name AS customer_name, g.guide_id, g.full_name AS guide_name
FROM trips t
	JOIN customers c ON c.customer_id = t.customer_id
	JOIN guides g ON g.guide_id = t.guide_id
WHERE t.status = 'Completed'
	AND t.departure_date >= '2025-01-01'
    AND t.departure_date < '2025-02-01'
ORDER BY t.departure_date, t.trip_id;

# 2. Đếm tổng số chuyến tham quan theo từng khu vực hoạt động trong quý I/2025, tính mọi trạng thái; hiển thị cả nhóm có số lượng bằng 0.
SELECT r.region_id, r.name AS region_name, COUNT(t.trip_id) AS total_trips
FROM regions r
	LEFT JOIN guides g ON g.region_id = r.region_id
	LEFT JOIN trips t ON t.guide_id = g.guide_id
		AND t.departure_date >= '2025-01-01'
		AND t.departure_date < '2025-04-01'
GROUP BY r.region_id, r.name
ORDER BY r.region_id;

# 3. Liệt kê các khách đại diện có ít nhất một chuyến tham quan chưa có báo cáo chuyến đi, loại trừ Cancelled. Mỗi người chỉ xuất hiện một lần.
SELECT c.customer_id, c.full_name AS customer_name
FROM customers c
WHERE EXISTS (
	SELECT 1 FROM trips t
    LEFT JOIN trip_reports r ON r.trip_id = t.trip_id
    WHERE t.customer_id = c.customer_id
		AND t.status <> 'Cancelled'
        AND r.report_id IS NULL
)
ORDER BY c.customer_id;

# 4. Tính phí hướng dẫn trung bình trên một giao dịch Completed của từng khu vực hoạt động, xét toàn bộ thời gian, chỉ lấy nhóm đã phát sinh chi phí.
SELECT rg.region_id, rg.name AS region_name, ROUND(AVG(r.fee), 2) AS avg_fee
FROM regions rg
	JOIN guides g ON g.region_id = rg.region_id
	JOIN trips t ON t.guide_id  = g.guide_id
	JOIN trip_reports r ON r.trip_id   = t.trip_id
WHERE t.status = 'Completed'
GROUP BY rg.region_id, rg.name
ORDER BY rg.region_id;

# 5. Liệt kê 3 hướng dẫn viên có nhiều chuyến tham quan Completed nhất trong năm 2025. Nếu bằng nhau, ưu tiên mã guide_id tăng dần; chỉ lấy đối tượng có giao dịch.
SELECT g.guide_id, g.full_name AS guide_name, COUNT(t.trip_id) AS completed_trips
FROM guides g
	JOIN trips t ON t.guide_id = g.guide_id
WHERE t.status = 'Completed'
	AND t.departure_date >= '2025-01-01'
	AND t.departure_date <  '2026-01-01'
GROUP BY g.guide_id, g.full_name
ORDER BY completed_trips DESC, g.guide_id ASC
LIMIT 3;

# 6. Tính tổng số tiền từng khách đại diện đã thanh toán trong năm 2025 theo payment_date; hiển thị cả người chưa trả tiền với tổng bằng 0.
SELECT c.customer_id, c.full_name AS customer_name, COALESCE(SUM(p.amount), 0) AS total_paid
FROM customers c
	LEFT JOIN trips t ON t.customer_id = c.customer_id
	LEFT JOIN payments p ON p.trip_id = t.trip_id
		AND p.payment_date >= '2025-01-01'
		AND p.payment_date <  '2026-01-01'
GROUP BY c.customer_id, c.full_name
ORDER BY c.customer_id;

# 7. Liệt kê các khách đại diện chưa có bất kỳ bản ghi thanh toán nào trong toàn bộ dữ liệu, kể cả người chưa có giao dịch.
SELECT c.customer_id, c.full_name AS customer_name
FROM customers c
	LEFT JOIN trips t ON t.customer_id = c.customer_id
    LEFT JOIN payments p ON t.trip_id = p.trip_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(p.payment_id) = 0
ORDER BY c.customer_id;

# 8. Liệt kê toàn bộ khách đại diện theo tổng phí hướng dẫn đã xác nhận giảm dần, không phụ thuộc đã thanh toán hay chưa; nếu bằng nhau, sắp theo mã tăng dần.
SELECT c.customer_id, c.full_name AS customer_name, COALESCE(SUM(r.fee), 0) AS total_fee
FROM customers c
	LEFT JOIN trips t ON t.customer_id = c.customer_id
    LEFT JOIN trip_reports r ON r.trip_id = t.trip_id
GROUP BY c.customer_id, customer_name
ORDER BY total_fee DESC, c.customer_id ASC;

# 9. Tính tỷ lệ hủy của từng hướng dẫn viên trong năm 2025: số chuyến tham quan Cancelled chia tổng số chuyến tham quan của năm, nhân 100. Làm tròn 2 chữ số thập phân; trả NULL nếu tổng bằng 0.
SELECT g.guide_id, g.full_name AS guide_name,
	   ROUND(
			SUM(CASE WHEN t.status = 'Cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(t.trip_id), 0) * 100, 2) AS cancel_rate
FROM guides g
	LEFT JOIN trips t ON t.guide_id = g.guide_id
		AND t.departure_date >= '2025-01-01'
        AND t.departure_date < '2026-01-01'
GROUP BY g.guide_id, g.full_name
ORDER BY g.guide_id;

# 10. Liệt kê các khách đại diện có hơn 3 chuyến tham quan Completed trong năm 2025, kèm số lần; sắp số lần giảm dần.
SELECT c.customer_id, c.full_name as customer_name, COUNT(t.trip_id) AS completed_trips
FROM customers c
	JOIN trips t ON t.customer_id = c.customer_id
	WHERE t.status = 'Completed'
		AND t.departure_date >= '2025-01-01'
        AND t.departure_date < '2026-01-01'
GROUP BY c.customer_id, c.full_name
HAVING COUNT(t.trip_id) > 3
ORDER BY completed_trips DESC, c.customer_id ASC;