# Quy Tắc Cô Lập Module & Các Anti-Pattern Cần Tránh Tuyệt Đối

Để đảm bảo khi code tính năng mới hoặc sửa tính năng cũ **không bao giờ làm hỏng các tính năng khác**, mọi lập trình viên và Agent AI đều phải tuân thủ nghiêm ngặt các quy tắc sau:

---

## 1. Danh Sách Các Anti-Pattern (Tuyệt Đối Cấm)

### ❌ Anti-Pattern 1: File "Thần Thánh" (God Component / God File)
- **Biểu hiện**: Nhét toàn bộ state, API calls, event listeners, modal render, table render vào 1 file duy nhất dài hàng ngàn dòng code.
- **Hậu quả**: Khi sửa một nút bấm nhỏ cũng có nguy cơ làm gãy logic của phím tắt, tải dữ liệu hoặc bảng tính.
- **Cách khắc phục**:
  - Tách UI thành các file nhỏ trong `components/`.
  - Tách logic thành Custom Hooks trong `hooks/`.
  - Tách thuật toán thuần túy thành Pure Functions trong `rules.ts`.

### ❌ Anti-Pattern 2: Nhập Khẩu Trực Tiếp Nội Bộ (Cross-Module Deep Imports)
- **Biểu hiện**: Module A import component nội bộ hoặc hook nội bộ của Module B:
  `import { MyModal } from '../orders/components/PrivateModal';`
- **Hậu quả**: Khi Module B đổi tên modal hoặc refactor, Module A đột ngột bị lỗi compile hoặc runtime error.
- **Cách khắc phục**:
  - Nếu là tài nguyên dùng chung: Chuyển lên thư mục dùng chung cấp cao (`src/components/`, `src/types/`, `src/utils/`).
  - Nếu là giao tiếp trạng thái: Dùng Custom Event hoặc State chung ở Parent.

### ❌ Anti-Pattern 3: Đột Biến Biến Toàn Cục Trực Tiếp (Global Mutable State)
- **Biểu hiện**: Dùng các biến `window.myAppGlobals.data = ...` hoặc biến `let` toàn cục để lưu trạng thái giữa các module.
- **Hậu quả**: Bất kỳ module nào cũng có thể vô tình ghi đè dữ liệu của module khác ở thời điểm bất kỳ (Race Condition).
- **Cách khắc phục**:
  - Lưu trữ bền vững (Persistent) thông qua `localStorage` có tiền tố rõ ràng (`elt_custom_shortcuts`, `elt_visible_columns`).
  - Cập nhật thông qua hàm Setter có đóng gói và phát sự kiện đồng bộ (`elt_shortcuts_updated`).

### ❌ Anti-Pattern 4: Phá Vỡ Cấu Trúc Database / Schema Gốc
- **Biểu hiện**: Xóa bỏ hoặc đổi tên các bảng/cột trong cơ sở dữ liệu đang có (`po_database.db`).
- **Hậu quả**: Toàn bộ dữ liệu lịch sử của doanh nghiệp hoặc các câu lệnh truy vấn cũ bị gãy vụn.
- **Cách khắc phục**:
  - Giữ nguyên 100% các cột và bảng cũ.
  - Khi cần lưu thông tin mới: Dùng bảng bổ trợ hoặc lưu trữ dạng cấu hình JSON độc lập.

---

## 2. Quy Tắc Cô Lập An Toàn (The Safe Isolation Checklist)

Trước khi chỉnh sửa bất kỳ module nào, hãy tự trả lời 4 câu hỏi:

1. **Phạm vi thay đổi có nằm trọn vẹn trong module này không?**
   - Nếu có: Tuyệt đối an toàn.
   - Nếu phải chạm vào file bên ngoài: Hãy kiểm tra xem có thể dùng Event Bus hoặc Props thay thế không.
2. **Các Props hoặc Interface công khai có bị đổi tên hay xóa trường nào không?**
   - Nếu có: Giữ lại trường cũ để đảm bảo tương thích ngược (Backward Compatible) và đánh dấu `@deprecated`.
3. **Các phím tắt hoặc sự kiện chuột có xung đột với các màn hình khác không?**
   - Kiểm tra kỹ bộ lọc `e.target instanceof HTMLInputElement` để tránh chặn thao tác gõ văn bản thông thường.
4. **Lệnh build có thành công với 0 lỗi không?**
   - Chạy `npm run build` trước và sau khi thực hiện thay đổi.
