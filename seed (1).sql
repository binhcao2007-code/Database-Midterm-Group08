USE tour_guide_mini;
SET NAMES utf8mb4;

INSERT INTO regions (region_id, name) VALUES
(1, 'Hà Nội'),
(2, 'Hạ Long'),
(3, 'Miền Trung'),
(4, 'Nha Trang'),
(5, 'TP. Hồ Chí Minh');

INSERT INTO guides (guide_id, full_name, email, language, region_id) VALUES
(1, 'Nguyễn Văn An',  'an.nguyen@tour.vn',   'Tiếng Việt, Tiếng Anh', 1),
(2, 'Trần Thị Bình',  'binh.tran@tour.vn',   'Tiếng Anh',             2),
(3, 'Lê Minh Cường',  'cuong.le@tour.vn',    'Tiếng Pháp',            3),
(4, 'Phạm Thu Dung',  'dung.pham@tour.vn',   'Tiếng Hàn',             3),
(5, 'Hoàng Văn Em',   'em.hoang@tour.vn',    'Tiếng Nga',             4),
(6, 'Vũ Thị Hoa',     'hoa.vu@tour.vn',      'Tiếng Nhật',            5);

INSERT INTO customers (customer_id, full_name, phone, email) VALUES
(1,  'Đặng Quốc Huy',    '0901000001', 'huy.dang@mail.com'),
(2,  'Bùi Thanh Lan',    '0901000002', 'lan.bui@mail.com'),
(3,  'Ngô Minh Khoa',    '0901000003', 'khoa.ngo@mail.com'),
(4,  'Đỗ Hồng Nhung',    '0901000004', 'nhung.do@mail.com'),
(5,  'Phan Gia Bảo',     '0901000005', 'bao.phan@mail.com'),
(6,  'Lý Mỹ Linh',       '0901000006', 'linh.ly@mail.com'),
(7,  'Trịnh Tuấn Kiệt',  '0901000007', 'kiet.trinh@mail.com'),
(8,  'Mai Phương Thảo',  '0901000008', 'thao.mai@mail.com'),
(9,  'Hồ Đức Thịnh',     '0901000009', 'thinh.ho@mail.com'),
(10, 'Dương Ánh Tuyết',  '0901000010', 'tuyet.duong@mail.com');

INSERT INTO trips (trip_id, customer_id, guide_id, departure_date, status, destination, participant_count) VALUES
(1,  1,  1, '2025-01-10', 'Completed', 'Hà Nội - Sapa',        4),
(2,  2,  2, '2025-01-20', 'Completed', 'Vịnh Hạ Long',         2),
(3,  1,  3, '2025-02-14', 'Completed', 'Đà Nẵng - Hội An',     3),
(4,  3,  4, '2025-03-08', 'Completed', 'Huế',                  5),
(5,  1,  5, '2025-05-15', 'Completed', 'Nha Trang',            2),
(6,  4,  1, '2025-07-04', 'Completed', 'Ninh Bình',            6),
(7,  1,  2, '2025-09-12', 'Completed', 'Vịnh Hạ Long',         2),
(8,  5,  3, '2025-11-20', 'Completed', 'Đà Nẵng',              4),
(9,  10, 5, '2025-03-25', 'Completed', 'Nha Trang',            3),
(10, 6,  6, '2024-12-20', 'Completed', 'Miền Tây - Cần Thơ',   2),
(11, 7,  1, '2026-12-10', 'Pending',   'Hà Nội - Mai Châu',    3),
(12, 8,  2, '2025-02-25', 'Cancelled', 'Vịnh Hạ Long',         2);

INSERT INTO trip_reports (report_id, trip_id, finished_at, itinerary_summary, feedback, fee) VALUES
(1,  1,  '2025-01-12 17:00:00', 'Hà Nội - Sapa 3 ngày 2 đêm',   'Rất hài lòng',        4000000),
(2,  2,  '2025-01-21 16:30:00', 'Du thuyền Hạ Long 2 ngày',      'Cảnh đẹp',            2500000),
(3,  3,  '2025-02-16 18:00:00', 'Đà Nẵng - Hội An 3 ngày',       'Hướng dẫn viên tốt',  3600000),
(4,  4,  '2025-03-10 17:30:00', 'Tham quan Đại Nội Huế',         NULL,                  5000000),
(5,  5,  '2025-05-17 15:00:00', 'Tắm biển, lặn ngắm san hô',     'Ổn',                  2800000),
(6,  6,  '2025-07-06 18:00:00', 'Tràng An - Bái Đính',           'Đông người',          6000000),
(7,  7,  '2025-09-13 16:00:00', 'Hạ Long 2 ngày 1 đêm',          'Tuyệt vời',           2500000),
(8,  8,  '2025-11-22 17:00:00', 'Bà Nà Hills - Cầu Vàng',        'Hài lòng',            4400000),
(9,  9,  '2025-03-27 16:00:00', 'Nha Trang - 4 đảo',             NULL,                  3000000),
(10, 10, '2024-12-22 17:00:00', 'Chợ nổi Cái Răng',              'Rất vui',             3200000);

INSERT INTO payments (payment_id, trip_id, amount, payment_date, method) VALUES
(1,  1,  4000000, '2025-01-12', 'BankTransfer'),
(2,  2,  2500000, '2025-01-21', 'Cash'),
(3,  3,  2000000, '2025-02-10', 'BankTransfer'),
(4,  3,  1600000, '2025-02-16', 'BankTransfer'),
(5,  4,  5000000, '2025-03-10', 'Card'),
(6,  5,  1000000, '2025-05-10', 'Cash'),
(7,  5,  1000000, '2025-05-17', 'Cash'),
(8,  6,  6000000, '2025-07-06', 'BankTransfer'),
(9,  7,  2500000, '2025-09-13', 'Card'),
(10, 8,  4400000, '2025-11-22', 'BankTransfer'),
(11, 10, 3200000, '2024-12-22', 'Cash');

-- ===== KIỂM TRA 1: KHÓA NGOẠI (mong đợi 0 dòng mỗi truy vấn) =====
SELECT g.guide_id FROM guides g LEFT JOIN regions r ON r.region_id = g.region_id WHERE r.region_id IS NULL;
SELECT t.trip_id FROM trips t LEFT JOIN customers c ON c.customer_id = t.customer_id WHERE c.customer_id IS NULL;
SELECT t.trip_id FROM trips t LEFT JOIN guides g ON g.guide_id = t.guide_id WHERE g.guide_id IS NULL;
SELECT r.report_id FROM trip_reports r LEFT JOIN trips t ON t.trip_id = r.trip_id WHERE t.trip_id IS NULL;
SELECT p.payment_id FROM payments p LEFT JOIN trips t ON t.trip_id = p.trip_id WHERE t.trip_id IS NULL;

-- ===== KIỂM TRA 2: TRẠNG THÁI VÀ BÁO CÁO (mong đợi 0 dòng) =====
-- Chuyến Completed nhưng thiếu báo cáo
SELECT t.trip_id FROM trips t
LEFT JOIN trip_reports r ON r.trip_id = t.trip_id
WHERE t.status = 'Completed' AND r.report_id IS NULL;

-- Báo cáo gắn với chuyến không phải Completed
SELECT r.report_id FROM trip_reports r
JOIN trips t ON t.trip_id = r.trip_id
WHERE t.status <> 'Completed';

-- Chuyến có hơn 1 báo cáo
SELECT trip_id, COUNT(*) FROM trip_reports GROUP BY trip_id HAVING COUNT(*) > 1;

-- ===== KIỂM TRA 3: TIỀN THU KHÔNG VƯỢT PHÍ (mong đợi 0 dòng) =====
SELECT r.trip_id, r.fee, SUM(p.amount) AS da_thu
FROM trip_reports r
JOIN payments p ON p.trip_id = r.trip_id
GROUP BY r.trip_id, r.fee
HAVING SUM(p.amount) > r.fee;

-- Thu tiền khi chưa có báo cáo/phí (mong đợi 0 dòng)
SELECT p.payment_id FROM payments p
LEFT JOIN trip_reports r ON r.trip_id = p.trip_id
WHERE r.trip_id IS NULL;

-- ===== KIỂM TRA 4: CÁC TÌNH HUỐNG CỦA ĐỀ (mong đợi CÓ dòng) =====
-- Khách có hơn 3 chuyến Completed trong 2025 -> khách 1
SELECT customer_id, COUNT(*) AS so_chuyen
FROM trips
WHERE status = 'Completed' AND YEAR(departure_date) = 2025
GROUP BY customer_id HAVING COUNT(*) > 3;

-- Chuyến còn nợ -> trip 5 (nợ 800.000); chuyến chưa trả đồng nào -> trip 9
SELECT r.trip_id, r.fee, COALESCE(SUM(p.amount), 0) AS da_thu,
       r.fee - COALESCE(SUM(p.amount), 0) AS con_no
FROM trip_reports r
LEFT JOIN payments p ON p.trip_id = r.trip_id
GROUP BY r.trip_id, r.fee
HAVING con_no > 0;

-- Chuyến trả nhiều lần -> trip 3, trip 5
SELECT trip_id, COUNT(*) AS so_lan FROM payments GROUP BY trip_id HAVING COUNT(*) > 1;

-- Khu vực chưa có chuyến trong quý I/2025 -> TP. Hồ Chí Minh
SELECT rg.region_id, rg.name FROM regions rg
WHERE NOT EXISTS (
  SELECT 1 FROM guides g JOIN trips t ON t.guide_id = g.guide_id
  WHERE g.region_id = rg.region_id
    AND t.departure_date BETWEEN '2025-01-01' AND '2025-03-31');

-- HDV chưa có chuyến năm 2025 -> HDV 6
SELECT g.guide_id, g.full_name FROM guides g
WHERE NOT EXISTS (
  SELECT 1 FROM trips t
  WHERE t.guide_id = g.guide_id AND YEAR(t.departure_date) = 2025);