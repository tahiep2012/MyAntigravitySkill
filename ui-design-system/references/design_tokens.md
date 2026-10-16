# Quy Chuẩn Biến Thiết Kế (Design Tokens Specification)

Tài liệu này định nghĩa hệ thống biến thiết kế (Design Tokens) nền tảng được áp dụng cho toàn bộ phần mềm và web.

---

## 1. Bảng Màu Ngữ Nghĩa (Semantic Color System)

### A. Màu Thương Hiệu & Điểm Nhấn (Brand / Primary)
- `blue-50`: Nền thẻ, highlight nhẹ khi chọn hàng
- `blue-100`: Thẻ phím tắt, badge trạng thái nhẹ
- `blue-500`: Viền focus ring, thanh vạch đánh dấu dòng
- `blue-600`: Nút bấm chính (Primary Button), icon hoạt động, liên kết
- `blue-700`: Trạng thái hover của nút bấm chính, văn bản nhấn mạnh

### B. Màu Trung Tính (Neutrals / Grayscale - Slate)
- `slate-50`: Nền các ô input, nền thanh toolbar, nền thẻ xem trước
- `slate-100`: Nền ứng dụng toàn cục (App background), nút thứ cấp (Secondary)
- `slate-200`: Đường viền phân cách chuẩn (`border-slate-200/80`)
- `slate-300`: Đường viền ô nhập khi hover, phím kbd
- `slate-400`: Văn bản phụ, icon phụ mờ, placeholder
- `slate-500`: Mô tả tính năng, văn bản caption
- `slate-700`: Nhãn trường dữ liệu (Label), chữ nút bấm thứ cấp
- `slate-800`: Văn bản nội dung bảng tính, tiêu đề nhóm
- `slate-900`: Tiêu đề trang chính (Heading 1), chữ đậm quan trọng

### C. Màu Trạng Thái Nghiệp Vụ (Semantic Feedback)
- **Thành công (Success - Emerald)**:
  - `emerald-50` / `emerald-200` / `emerald-600` / `emerald-700`: Đã thanh toán, đã duyệt, lưu thành công.
- **Cảnh báo / Chờ (Warning - Amber)**:
  - `amber-50` / `amber-200` / `amber-600` / `amber-800`: Đang chờ phê duyệt, cảnh báo xung đột phím tắt, hàng sắp hết hạn.
- **Nguy hiểm / Hủy (Danger - Rose)**:
  - `rose-50` / `rose-200` / `rose-600` / `rose-700`: Đơn hàng bị hủy, lỗi hệ thống, nút xóa dữ liệu.
- **Thông tin (Info - Sky / Cyan)**:
  - `sky-50` / `sky-200` / `sky-600`: Phân hệ kho, hướng dẫn thao tác.

---

## 2. Thang Đo Bo Góc (Border Radii)

| Token | Giá trị CSS | Trường hợp áp dụng |
| :--- | :--- | :--- |
| `rounded-md` | `6px` | Thẻ phím bấm kbd, badge kích thước nhỏ |
| `rounded-xl` | `12px` | Ô nhập dữ liệu (Input), Thẻ Badge, Nút bấm nhỏ (Size Sm), Item dropdown |
| `rounded-2xl` | `16px` | Nút bấm tiêu chuẩn (Button Size Md), Hộp card con, Hộp thoại xác nhận nhỏ |
| `rounded-3xl` | `24px` | Khung Card trang lớn, Cửa sổ Modal chính, Banner đầu trang |
| `rounded-full` | `9999px` | Chấm tròn trạng thái (Status dot), Avatar người dùng, Pill bộ lọc |

---

## 3. Hệ Thống Bóng Đổ (Elevation & Shadows)

- `shadow-2xs`: Độ sâu viền siêu nhẹ cho phím kbd, thẻ con (`0 1px 1px rgba(0,0,0,0.05)`).
- `shadow-xs`: Độ sâu tiêu chuẩn cho các thẻ Card và nút bấm phẳng.
- `shadow-md`: Độ sâu cho banner nổi và nút bấm chính khi hover.
- `shadow-2xl`: Độ sâu lớn cho cửa sổ Modal popup nổi trên lớp phủ mờ (Backdrop).
