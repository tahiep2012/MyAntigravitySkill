# Đặc Tả Kỹ Thuật Các Component Nguyên Tử (Component Specs)

Tài liệu này mô tả chi tiết các Component chuẩn tại `@/components/ui` để áp dụng thống nhất trong toàn bộ dự án.

---

## 1. `<Button />` (Nút bấm tương tác)

### Props:
- `variant`:
  - `primary`: Nền xanh dương `bg-blue-600 hover:bg-blue-700`, chữ trắng (Dùng cho hành động quan trọng nhất trang: Lưu, Thêm mới, Xác nhận, Tra Cứu).
  - `secondary`: Nền xám nhạt `bg-slate-100 hover:bg-slate-200`, chữ xám đậm `text-slate-700` (Dùng cho hành động phụ: Đóng, Hủy bỏ, Làm mới).
  - `outline`: Nền trong suốt, viền xám `border border-slate-200 hover:bg-slate-50` (Dùng cho hành động bổ trợ: Xuất Excel, Tùy chọn).
  - `ghost`: Nền trong suốt, chỉ hiện nền khi hover (Dùng cho icon button trên toolbar).
  - `danger`: Nền đỏ `bg-rose-600 hover:bg-rose-700` (Dùng cho xóa, hủy đơn, reset toàn bộ).
  - `success`: Nền xanh lá `bg-emerald-600 hover:bg-emerald-700` (Dùng cho duyệt đơn, hoàn tất thanh toán).
- `size`:
  - `xs`: Cao 28px, font 11px, bo góc 10px (`rounded-lg`).
  - `sm`: Cao 34px, font 12px, bo góc 12px (`rounded-xl`).
  - `md`: Cao 42px, font 13px, bo góc 16px (`rounded-2xl`) - **Mặc định**.
  - `lg`: Cao 48px, font 14px, bo góc 16px (`rounded-2xl`).
- `loading`: Tự động hiện vòng xoay `Loader2` và vô hiệu hóa click.
- `icon`: Component Lucide icon truyền vào trực tiếp.

---

## 2. `<SearchInput />` (Thanh tìm kiếm & Ô lọc chuẩn mực)

### Quy chuẩn hình học:
- **Chiều cao chuẩn**: 44px (chuẩn desktop vừa vặn) hoặc 48px (chuẩn nổi bật màn hình chính).
- **Bo góc**: `rounded-2xl` (16px).
- **Màu nền**: `bg-slate-50` viền `border border-slate-200/90`, bóng đổ nhẹ `shadow-xs`.
- **Focus**: `focus:ring-2 focus:ring-blue-500 focus:bg-white focus:border-transparent`.
- **Icon Kính lúp**: `w-5 h-5 text-slate-400 absolute left-3.5 top-3.5`.
- **Tích hợp sẵn**:
  - `actionButton`: Slot nhúng nút hành động (ví dụ nút *"Tra Cứu"* hoặc *"Tìm Nhanh"*) ngay mép phải (`absolute right-2 top-2`).
  - `onClear`: Nút `X` tự động xuất hiện khi có văn bản để xóa nhanh 1 chạm.
  - `shortcutHint`: Gợi ý phím tắt (`Ctrl+K` hoặc `Enter`).

---

## 3. `<Input />` (Ô nhập liệu form & dữ liệu)

### Quy chuẩn:
- Chiều cao chuẩn: 40px, bo góc `rounded-xl` hoặc `rounded-2xl`.
- Hỗ trợ `label`, `error`, `helperText`, icon tiền tố (`iconLeft`) hoặc hậu tố (`iconRight`).

---

## 4. `<IconButton />` (Nút biểu tượng thao tác trên dòng)

### Quy chuẩn:
- Vuông vức chuẩn: `32x32px` (compact) hoặc `36x36px` (standard), bo góc `rounded-xl`.
- Màu nền hover nhẹ nhàng: `hover:bg-blue-50 text-slate-400 hover:text-blue-600` hoặc `hover:bg-rose-50 text-slate-300 hover:text-rose-600`.
- Chuyên dùng cho các hành động trên dòng bảng danh sách: Phát âm, Xem chi tiết, Đánh dấu sao, Xóa khỏi danh sách.

---

## 5. `<EmptyState />` (Khung hiển thị trạng thái chưa có dữ liệu)

### Quy chuẩn:
- Viền nét đứt: `border-2 border-dashed border-slate-200`.
- Bo góc: `rounded-2xl` hoặc `rounded-3xl`.
- Khối icon trung tâm: Hộp tròn `w-12 h-12 rounded-full bg-slate-100 flex items-center justify-center`.
- Tiêu đề: `text-sm font-bold text-slate-700`.
- Mô tả hướng dẫn: `text-xs text-slate-400 max-w-sm mx-auto`.
- Nút hành động CTA tùy chọn phía dưới (ví dụ *"Tạo mới ngay"* hoặc *"Bắt đầu tra cứu"*).

---

## 6. `<Card />` (Khung chứa & Panel dữ liệu)

### Biến thể:
- `variant="default"`: Nền trắng `bg-white`, viền `border-slate-200/80`, bóng đổ `shadow-xs`.
- `variant="flat"`: Nền xám nhẹ `bg-slate-50`, viền `border-slate-200/60`.
- `variant="dashed"`: Nền trong suốt hoặc xám nhẹ, viền nét đứt `border-2 border-dashed border-slate-200`.
- `variant="bordered"`: Viền dày nổi khối `border-2 border-slate-200`.
- `variant="hud"`: Nền trắng với bóng đổ nổi bật chuyên dùng cho Quick HUD `shadow-hud`.

---

## 7. `<Badge />` (Thẻ nhãn trạng thái)

### Biến thể:
- `variant="brand"`: Chữ xanh, nền xanh nhạt.
- `variant="success"`: Chữ xanh lá, nền xanh lá nhạt.
- `variant="warning"`: Chữ cam, nền cam nhạt.
- `variant="danger"`: Chữ đỏ, nền đỏ nhạt.
- `dot={true}`: Tự động thêm chấm tròn màu tương ứng phía trước.

---

## 8. `<Modal />` (Cửa sổ hộp thoại)

### Quy chuẩn:
- Lớp nền mờ: `bg-slate-900/40 backdrop-blur-xs`.
- Hộp thoại: `rounded-3xl`, viền `border-slate-200`, bóng đổ `shadow-2xl`.
- Thanh tiêu đề riêng biệt có icon nhận diện và nút `X` đóng nhanh.
- Tự động đóng khi nhấn phím `Escape` hoặc click ra ngoài lớp nền.
