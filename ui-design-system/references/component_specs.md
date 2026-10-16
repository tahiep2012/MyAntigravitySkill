# Đặc Tả Kỹ Thuật Các Component Nguyên Tử (Component Specs)

Tài liệu này mô tả chi tiết các Component chuẩn tại `@/components/ui` để áp dụng thống nhất trong toàn bộ dự án.

---

## 1. `<Button />` (Nút bấm tương tác)

### Props:
- `variant`:
  - `primary`: Nền xanh dương `bg-blue-600`, chữ trắng (Dùng cho hành động quan trọng nhất trang: Lưu, Thêm mới, Xác nhận).
  - `secondary`: Nền xám nhạt `bg-slate-100`, chữ xám đậm (Dùng cho hành động phụ: Đóng, Hủy bỏ, Làm mới).
  - `outline`: Nền trong suốt, viền xám `border-slate-300` (Dùng cho hành động bổ trợ: Xuất Excel, Tùy chọn).
  - `ghost`: Nền trong suốt, chỉ hiện nền khi hover (Dùng cho icon button trên toolbar).
  - `danger`: Nền đỏ `bg-rose-600` (Dùng cho xóa, hủy đơn, reset toàn bộ).
  - `success`: Nền xanh lá `bg-emerald-600` (Dùng cho duyệt đơn, hoàn tất thanh toán).
- `size`:
  - `sm`: Cao 30px, font 12px, bo góc 12px (`rounded-xl`).
  - `md`: Cao 40px, font 12px, bo góc 16px (`rounded-2xl`) - **Mặc định**.
  - `lg`: Cao 46px, font 14px, bo góc 16px (`rounded-2xl`).
  - `icon`: Vuông 36x36px.
- `loading`: Tự động hiện vòng xoay `Loader2` và vô hiệu hóa click.
- `icon`: Component Lucide icon truyền vào trực tiếp.

---

## 2. `<Input />` & `<SearchInput />` (Ô nhập liệu & Tìm kiếm)

### Quy chuẩn:
- Chiều cao chuẩn desktop: 38px - 40px.
- Bo góc: `rounded-xl`.
- Nền mặc định: `bg-slate-50`, viền `border-slate-200`. Khi focus chuyển thành nền trắng và hiện viền xanh dịu `ring-2 ring-blue-100 border-blue-500`.
- `<SearchInput />` tự động tích hợp:
  - Icon kính lúp bên trái.
  - Nút `X` xóa nhanh văn bản khi có dữ liệu.
  - Phím tắt gợi ý (ví dụ: `Ctrl+K`).

---

## 3. `<Badge />` (Thẻ nhãn trạng thái)

### Biến thể:
- `variant="brand"`: Chữ xanh, nền xanh nhạt.
- `variant="success"`: Chữ xanh lá, nền xanh lá nhạt (Đã giao hàng, Đã trả tiền).
- `variant="warning"`: Chữ cam, nền cam nhạt (Chờ xử lý, Sắp trễ hạn).
- `variant="danger"`: Chữ đỏ, nền đỏ nhạt (Đã hủy, Lỗi).
- `dot={true}`: Tự động thêm chấm tròn màu tương ứng phía trước.

---

## 4. `<PageHeader />` (Tiêu đề trang đồng nhất)

### Biến thể:
- `variant="clean"`: Nền trong suốt, biểu tượng trong khối bo góc `rounded-2xl`, tiêu đề trang `text-xl font-bold`, kèm các nút bấm thao tác phía bên phải.
- `variant="banner"`: Dải màu gradient ấn tượng bo góc `rounded-3xl` lớn với bóng đổ, dùng cho các phân hệ cần điểm nhấn mạnh mẽ.

---

## 5. `<Modal />` (Cửa sổ hộp thoại)

### Quy chuẩn:
- Lớp nền mờ: `bg-slate-900/40 backdrop-blur-xs`.
- Hộp thoại: `rounded-3xl`, viền `border-slate-300`, bóng đổ `shadow-2xl`.
- Thanh tiêu đề riêng biệt có icon nhận diện và nút `X` đóng nhanh.
- Tự động đóng khi nhấn phím `Escape` hoặc click ra ngoài lớp nền.
