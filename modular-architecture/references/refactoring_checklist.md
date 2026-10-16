# Bảng Kiểm Tra Chống Lỗi Dây Chuyền (Zero-Regression Checklist)

Mỗi khi phát triển tính năng mới hoặc nâng cấp tính năng cũ, hãy thực hiện tuần tự danh sách kiểm tra sau trước khi đóng gói hoặc bàn giao:

---

## Giai Đoạn 1: Phân Tích & Xác Định Ranh Giới (Boundary Isolation)
- [ ] Xác định rõ tính năng thuộc về module nào trong `src/modules/`.
- [ ] Nếu là tính năng hoàn toàn mới: Tạo thư mục mới `src/modules/<feature_name>/` độc lập.
- [ ] Không chỉnh sửa bất kỳ dòng code nào của các module không liên quan.

## Giai Đoạn 2: Kiểm Soát Kiểu Dữ Liệu & Giao Diện (Type Safety)
- [ ] Mọi kiểu dữ liệu mới được đặt tại `src/types/<feature>.ts`.
- [ ] Không sửa đổi các thuộc tính bắt buộc (`required fields`) của các Interface cũ để tránh làm hỏng các nơi đang gọi.
- [ ] Không sử dụng kiểu `any` bừa bãi.

## Giai Đoạn 3: Kiểm Soát Sự Kiện & Phím Tắt (Event & Shortcut Isolation)
- [ ] Các sự kiện toàn cục (`keydown`, `wheel`, `click`) phải có cơ chế chặn can thiệp khi người dùng đang nhập liệu trong ô input/textarea.
- [ ] Các sự kiện lắng nghe đều có hàm dọn dẹp tương ứng trong `useEffect` (`removeEventListener`) để tránh rò rỉ bộ nhớ (Memory Leak).
- [ ] Các thông báo liên module sử dụng CustomEvent có tên tiền tố rõ ràng (ví dụ: `app_<tên_sự_kiện>_updated`).

## Giai Đoạn 4: Kiểm Soát Cơ Sở Dữ Liệu & Backend (Data Integrity)
- [ ] 100% các câu lệnh SQL không can thiệp xóa hay thay đổi kiểu dữ liệu các cột hiện có.
- [ ] Các câu lệnh thêm mới đều có kiểm tra tồn tại an toàn (`IF NOT EXISTS` hoặc fallback).

## Giai Đoạn 5: Kiểm Tra Tự Động & Đóng Gói (Build Verification)
- [ ] Chạy lệnh kiểm tra cú pháp và build sản phẩm: `npm run build`.
- [ ] Đảm bảo 0 lỗi biên dịch (Exit code 0).
- [ ] Chạy thử ứng dụng để xác thực:
  - Tính năng mới hoạt động đúng yêu cầu.
  - Các tính năng cũ xung quanh vẫn hoạt động trơn tru 100%.
