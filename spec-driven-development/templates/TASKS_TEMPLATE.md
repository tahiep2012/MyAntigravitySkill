# DANH SÁCH CÔNG VIỆC THỰC THI (LIVING TASK CHECKLIST)

> **Mã Epic**: `EPIC-XX`  
> **Tên Tính Năng**: `[Tên tính năng]`  
> **Tài Liệu Đặc Tả Trực Thuộc**: [`SPEC.md`](./SPEC.md)  
> **Tiến Độ Hiện Tại**: `[ 0 / 10 Tasks Hoàn Thành - 0% ]`  
> **Trạng Thái Giai Đoạn**: `[ ] PENDING | [/] IN_PROGRESS | [x] ACCEPTED`  

---

## 📌 Hướng Dẫn Vận Hành Cho AI Agent (Anti-Context Drift Guide)

1. **Mỏ Neo Đĩa Cứng**: Bắt buộc đọc file này trước khi code bất cứ dòng nào.
2. **Quy Tắc Đánh Dấu**:
   - `[ ]`: Chưa làm.
   - `[/]`: Đang làm (kèm mô tả bước hiện tại).
   - `[x]`: Đã làm xong (kèm bằng chứng test pass).
3. **Cập Nhật Ngay Lập Tức**: Ngay khi hoàn thành 1 task và chạy test pass, BẮT BUỘC gọi tool cập nhật trạng thái `[x]` vào file này trên đĩa, không bao giờ để dồn.

---

## 📋 Danh Sách Hạng Mục Công Việc Theo Thứ Tự Thực Thi

### Giai Đoạn 1: Thiết Kế & Nền Tảng Dữ Liệu (Database & Types)
- [ ] **Task 1.1**: Định nghĩa TypeScript Interfaces & Types trong `src/modules/[feature]/types.ts`
  - *Tiêu chí hoàn thành*: Export đầy đủ các kiểu dữ liệu cần thiết, không dùng kiểu `any`.
- [ ] **Task 1.2**: Viết migration CSDL SQLite và Rust Structs trong `src-tauri/src/[feature].rs`
  - *Tiêu chí hoàn thành*: Bảng CSDL tạo đúng schema, index được thiết lập, lệnh Rust compile thành công.
- [ ] **Task 1.3**: Viết Unit Test cho tầng Backend/Database
  - *Tiêu chí hoàn thành*: Chạy test CRUD thành công trên CSDL tạm.

### Giai Đoạn 2: Logic Nghiệp Vụ & Hooks (Business Logic & Hooks)
- [ ] **Task 2.1**: Viết các quy tắc nghiệp vụ thuần túy và công thức trong `src/modules/[feature]/rules.ts`
  - *Tiêu chí hoàn thành*: 100% Pure Functions, không phụ thuộc vào React hay DOM.
- [ ] **Task 2.2**: Xây dựng Custom Hook quản lý dữ liệu `use[Feature].ts`
  - *Tiêu chí hoàn thành*: Quản lý đầy đủ state: data, loading, error, refreshAction.
- [ ] **Task 2.3**: Viết Unit Test cho `rules.ts` kiểm thử các trường hợp dữ liệu bình thường và dữ liệu bẩn
  - *Tiêu chí hoàn thành*: Test phủ các ca null, số âm, chuỗi đặc biệt.

### Giai Đoạn 3: Giao Diện Người Dùng & 4 Trạng Thái (UI & 4 States)
- [ ] **Task 3.1**: Xây dựng UI Component chính tái sử dụng các khối nguyên tử (`@/components/ui`)
  - *Tiêu chí hoàn thành*: Đảm bảo đúng Design Tokens, bo góc, màu sắc ngữ nghĩa.
- [ ] **Task 3.2**: Hiện thực hóa đầy đủ 4 trạng thái giao diện:
  - [ ] Trạng thái Loading (Skeleton / Pulse)
  - [ ] Trạng thái Empty (Khi rỗng và khi không khớp bộ lọc)
  - [ ] Trạng thái Error (Banner báo lỗi dịu + nút Thử lại)
  - [ ] Trạng thái Success (Bảng dữ liệu / Lưới thẻ)
- [ ] **Task 3.3**: Cài đặt phím tắt bàn phím và phản hồi tương tác (Keyboard shortcuts & Micro-interactions)
  - *Tiêu chí hoàn thành*: Hỗ trợ các phím tắt theo đặc tả trong `SPEC.md`.

### Giai Đoạn 4: Đóng Gói Public API & Tích Hợp Module (Integration & Export)
- [ ] **Task 4.1**: Tạo file `src/modules/[feature]/index.ts` làm Public API duy nhất
  - *Tiêu chí hoàn thành*: Chỉ export các Component và Hook được phép dùng ra bên ngoài; cấm rò rỉ file nội bộ.
- [ ] **Task 4.2**: Tích hợp Component vào màn hình chính thông qua Public API
  - *Tiêu chí hoàn thành*: Màn hình cha không chứa bất kỳ logic nội bộ nào của phân hệ này.

### Giai Đoạn 5: Kiểm Thử Đích Danh & Nghiệm Thu (Feature QA Verification)
- [ ] **Task 5.1**: Thêm các test case đích danh bao quát tính năng này vào `tests/test_qa_lifecycle.ts`
  - *Tiêu chí hoàn thành*: Có ít nhất 3-5 test cases kiểm thử trực tiếp các hành vi và quy tắc của tính năng.
- [ ] **Task 5.2**: Chạy kiểm thử tự động toàn hệ thống `npm run test`
  - *Tiêu chí hoàn thành*: Đạt 100% test pass (Tầng 0 Modular Gate + Tầng 1-3 Unit/Integration).
- [ ] **Task 5.3**: Bàn giao bản build / demo và cập nhật trạng thái trong `docs/specs/ROADMAP.md`
  - *Tiêu chí hoàn thành*: Người dùng duyệt nghiệm thu, chuyển trạng thái Epic sang `[x] COMPLETED`.

---

## 📝 Nhật Ký Thực Thi Từng Bước (Living Execution Log)

| Thời Gian | Task ID | Hành Động Đã Thực Hiện | Bằng Chứng Kiểm Thử / Ghi Chú |
| :--- | :--- | :--- | :--- |
| `YYYY-MM-DD HH:mm` | `Task 1.1` | Khởi tạo types.ts | Biên dịch TypeScript không có lỗi |
| `...` | `...` | `...` | `...` |
