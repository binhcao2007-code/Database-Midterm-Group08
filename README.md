# Đồ án Giữa kỳ - Hệ quản trị Cơ sở dữ liệu
**Đề 10: Quản lý dịch vụ hướng dẫn du lịch**

## 👥 Thông tin chung
- **Giảng viên hướng dẫn:** Trần Đức Minh
- **Nhóm thực hiện:** Nhóm 08
- **Thành viên:**
  1. Cao Đình Bình - 11251272
  2. Nguyễn Bình Minh - 11255394
  3. Vũ Hoàng Sơn - 11257428

## 📝 Giới thiệu dự án
Dự án thiết kế cơ sở dữ liệu quan hệ cho hệ thống quản lý dịch vụ hướng dẫn du lịch (Database: `tour_guide_mini`). Hệ thống giúp quản lý nhóm hướng dẫn viên theo khu vực, lịch dẫn đoàn, báo cáo hoàn thành chuyến đi và thống kê tiền dịch vụ, công nợ.

## 📂 Cấu trúc thư mục
- `Bao_cao_Giua_ky_Nhom08.pdf`: Báo cáo chi tiết của dự án bao gồm thiết kế lược đồ, giải thích logic và minh họa kết quả.
- `schema.sql`: Tập lệnh DDL để khởi tạo cơ sở dữ liệu, định nghĩa cấu trúc 6 bảng (`regions`, `guides`, `customers`, `trips`, `trip_reports`, `payments`) và thiết lập các khóa chính, khóa ngoại, ràng buộc (constraints).
- `seed.sql`: Tập lệnh DML nạp dữ liệu mẫu bao phủ các trường hợp nghiệp vụ, kèm theo các câu lệnh `SELECT` kiểm chứng tính toàn vẹn của khóa ngoại và logic thời gian/chi phí.
- `views.sql`: Khởi tạo 3 View thống kê (`v_detail`, `v_group_summary`, `v_debt`) phục vụ việc theo dõi chi tiết chuyến đi, tổng hợp theo khu vực và tính toán công nợ khách hàng.
- `queries.sql`: 10 câu lệnh truy vấn (DML/SELECT) giải quyết các yêu cầu khai thác dữ liệu từ cơ bản đến phức tạp (JOIN, GROUP BY, HAVING, Subquery).

## 🚀 Hướng dẫn cài đặt và chạy mã nguồn
Để đảm bảo toàn vẹn dữ liệu và tránh lỗi thiếu bảng/khóa tham chiếu, vui lòng thực thi các tệp `.sql` trên môi trường MySQL/MariaDB theo đúng thứ tự sau:

1. Chạy `schema.sql` để tạo CSDL `tour_guide_mini` và các bảng.
2. Chạy `seed.sql` để nạp dữ liệu mẫu và kiểm tra ràng buộc.
3. Chạy `views.sql` để tạo các View thống kê.
4. Chạy `queries.sql` để kiểm tra kết quả 10 truy vấn nghiệp vụ.

## ⚠️ Lưu ý hệ thống
- Môi trường: MySQL
- Bảng mã: `utf8mb4` - Collate: `utf8mb4_unicode_ci`
