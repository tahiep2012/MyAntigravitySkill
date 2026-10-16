# Cẩm Nang Tương Tác Kỹ Năng Spec-Driven Development (User Guide)

Tài liệu này hướng dẫn cách tương tác tự nhiên giữa Người dùng (User / Tech Lead) và AI Agent (Antigravity) khi triển khai các dự án quy mô vừa và lớn.

---

## 💬 5 Kịch Bản Tương Tác Thực Tế

### Kịch Bản 1: Khởi Động Dự Án Lớn Hoặc Hệ Thống Mới (Lập Lộ Trình)
*Khi anh có một ý tưởng phần mềm lớn hoặc một module đồ sộ gồm nhiều phần:*
- **Anh chỉ cần nhắn:**
  > *"Anh muốn làm hệ thống Quản lý Bán hàng & Kho, gồm các phần: Đăng nhập phân quyền, Quản lý đơn hàng, Tra cứu tồn kho, và Báo cáo xuất Excel. Em hãy lập lộ trình tổng thể và chia phân hệ giúp anh."*
- **Antigravity sẽ tự động thực hiện:**
  1. Kích hoạt kỹ năng `spec-driven-development`.
  2. Tạo ngay thư mục `docs/specs/` trên đĩa cứng dự án.
  3. Soạn file `docs/specs/ROADMAP.md`: Phân chia thành Phase 1, Phase 2, Phase 3, vẽ sơ đồ phụ thuộc (Dependency Graph) và bảng ma trận các Epic.
  4. Trình bày lộ trình tổng quan cho anh và hỏi: *"Anh xem lộ trình này đã chuẩn chưa, anh muốn ưu tiên triển khai Phân hệ nào trước?"*

---

### Kịch Bản 2: Lập Đặc Tả Chi Tiết Cho Một Tính Năng Cụ Thể
*Khi anh muốn bắt tay vào một phân hệ cụ thể trong lộ trình:*
- **Anh chỉ cần nhắn:**
  > *"Em lên chi tiết đặc tả cho Phân hệ 1: Quản lý Đơn hàng đi em."*
- **Antigravity sẽ tự động thực hiện:**
  1. Tạo thư mục riêng: `docs/specs/features/01-order-management/`.
  2. Tạo file `SPEC.md` với **đủ 7 mục chuẩn mực**: Luồng người dùng, ranh giới module, bảng CSDL SQLite, 4 trạng thái UI (Loading/Empty/Error/Success), quy tắc nghiệp vụ, xử lý dữ liệu bẩn và tiêu chí nghiệm thu.
  3. Tạo file `TASKS.md` chia nhỏ thành các task vi mô (`[ ] Task 1.1`, `[ ] Task 1.2`...).
  4. Trình bày bản đặc tả cho anh xem và **DỪNG LẠI CHỜ LỆNH DUYỆT** (Tuân thủ cổng an toàn `explicit-confirmation-gate`, tuyệt đối không tự ý viết code).

---

### Kịch Bản 3: Ra Lệnh Triển Khai Cuốn Chiếu
*Sau khi anh đã đọc qua đặc tả và cảm thấy ưng ý:*
- **Anh chỉ cần nhắn:**
  > *"Ok em, anh duyệt đặc tả này rồi, triển khai đi em!"*
- **Antigravity sẽ tự động thực hiện:**
  1. Mở file `TASKS.md` trên đĩa và thực hiện tuần tự từng task một (Single-Piece Flow).
  2. Với mỗi task: Viết code $\rightarrow$ Viết test tương ứng $\rightarrow$ Chạy `npm run test` $\rightarrow$ Mở `TASKS.md` đổi ngay `[ ]` thành `[x]`.
  3. Tuyệt đối **không làm lan man** sang phân hệ khác khi phân hệ này chưa xong.
  4. Sau khi hoàn thành 100% tasks và pass 100% test, Antigravity đóng gói hoặc chạy thử nghiệm và báo cáo:
     > *"Phân hệ Đơn hàng đã hoàn thành 10/10 tasks, 100% test cases PASS. Em gửi anh bản chạy thử để anh nghiệm thu!"*

---

### Kịch Bản 4: Thay Đổi Yêu Cầu Giữa Chừng (Spec-First)
*Trong lúc đang làm, anh muốn bổ sung thêm tính năng hoặc đổi cách hoạt động:*
- **Anh chỉ cần nhắn:**
  > *"Anh muốn đổi: danh sách lọc cột thì chữ (TRỐNG) phải nằm trên cùng, và thêm phím tắt Shift+D để xóa lọc nhé."*
- **Antigravity sẽ tự động thực hiện (Chính sách Spec-First):**
  1. **Không vội sửa code ngay** (để tránh phá vỡ kiến trúc cũ).
  2. Mở file `SPEC.md` của phân hệ đó, cập nhật yêu cầu mới vào Mục 4 (Giao diện & Phím tắt) và Mục 5 (Quy tắc lọc).
  3. Thêm task vào `TASKS.md`.
  4. Báo cáo lại với anh: *"Em đã cập nhật đặc tả trên đĩa, giờ em tiến hành sửa code và viết test bổ sung nhé."*

---

### Kịch Bản 5: Kiểm Tra Tiến Độ Bất Cứ Lúc Nào (Chống Trôi / Quên)
*Sau nhiều ngày làm việc hoặc khi cửa sổ chat đã quá dài:*
- **Anh chỉ cần nhắn:**
  > *"Dự án mình đang làm tới đâu rồi em? Còn những tính năng nào chưa làm?"*
- **Antigravity sẽ tự động thực hiện:**
  1. Không cần phải lục lại hàng trăm tin nhắn chat cũ (vốn đã bị nén hoặc trôi mất).
  2. Đọc trực tiếp các file mỏ neo trên đĩa cứng: `docs/specs/ROADMAP.md` và `docs/specs/features/.../TASKS.md`.
  3. Lập tức báo cáo chính xác 100%:
     > *"Dự án có 4 phân hệ:  
     > • Phase 1 (Đơn hàng): ĐÃ XONG (100% test pass).  
     > • Phase 2 (Kế hoạch chi): ĐANG LÀM dở ở Task 2.3 (UI Modal).  
     > • Phase 3 (Xuất RPA) & Phase 4 (Kho): CHƯA BẮT ĐẦU."*

---

## 📋 Bảng Câu Lệnh Nhanh (Cheat Sheet)

| Khi anh muốn... | Anh chỉ cần gõ tin nhắn ngắn gọn: |
| :--- | :--- |
| **Bắt đầu dự án lớn** | *"Lập lộ trình tổng thể và chia phân hệ cho dự án [Tên] này đi em"* |
| **Soạn chi tiết tính năng** | *"Lên đặc tả chi tiết và checklist cho phân hệ [Tên Phân Hệ]"* |
| **Bắt đầu viết mã nguồn** | *"Anh duyệt đặc tả rồi, triển khai đi em"* |
| **Bổ sung / Đổi yêu cầu** | *"Cập nhật lại đặc tả: anh muốn thêm [yêu cầu mới] vào phân hệ [Tên]"* |
| **Tra cứu trạng thái dự án** | *"Dự án đang tới bước nào rồi em, kiểm tra mỏ neo đĩa cứng báo anh"* |
| **Nghiệm thu chuyển bước** | *"Anh nghiệm thu Phase 1 rồi, bắt đầu Phase 2 đi em"* |
