# Bảng Thẩm Định Chuẩn Hóa Giao Diện (UI/UX Checklist)

Trước khi bàn giao bất kỳ màn hình hoặc tính năng giao diện nào, hãy kiểm tra danh sách tiêu chuẩn sau:

---

## 1. Kiểm Tra Tính Nhất Quán Về Thị Giác (Visual Consistency)
- [ ] Tất cả nút bấm đều sử dụng component `<Button>` từ `@/components/ui`. Không tồn tại thẻ `<button>` với class tự chế lạ lẫm.
- [ ] Tất cả các ô tìm kiếm đều dùng `<SearchInput>`.
- [ ] Tiêu đề trang dùng chung cấu trúc `<PageHeader>`.
- [ ] Màu sắc tuân theo đúng bảng màu Semantic (`Blue-600` cho Brand, `Emerald-600` cho Thành công, `Rose-600` cho Lỗi, `Slate` cho Trung tính). Không có mã màu HEX lạ ngoài Design Tokens.
- [ ] Bo góc thống nhất: `rounded-xl` cho phần tử nhỏ (badge, input), `rounded-2xl` cho nút bấm, `rounded-3xl` cho thẻ card và modal.

---

## 2. Kiểm Tra Trạng Thái Tương Tác (Interactive States)
- [ ] Nút bấm có hiệu ứng `hover` và hiệu ứng lún nhẹ khi bấm `active:scale-[0.98]`.
- [ ] Nút bấm có trạng thái `disabled` mờ 50% và con trỏ `not-allowed` khi không thỏa mãn điều kiện.
- [ ] Ô nhập liệu có viền sáng nhẹ khi focus và không bị lỗi tràn viền.
- [ ] Khi đang tải dữ liệu: Nút bấm hiển thị vòng xoay `loading` và chặn thao tác bấm đúp (double submission).

---

## 3. Kiểm Tra Bố Cục & Trải Nghiệm Thao Tác (Layout & UX)
- [ ] Vùng nội dung bảng hoặc danh sách tự động co giãn (`flex-1 min-h-0`) để khớp khít với màn hình, thanh cuộn mượt mà không bị vỡ giao diện.
- [ ] Cửa sổ Modal có thể đóng nhanh bằng phím `Escape` hoặc click nền mờ.
- [ ] Toàn bộ icon được lấy từ một thư viện duy nhất (`lucide-react`) với kích thước hài hòa (`w-4 h-4`).
- [ ] Văn bản tiếng Việt có dấu đầy đủ, chuẩn chính tả, ngữ điệu chuyên nghiệp.
