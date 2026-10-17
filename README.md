# Bộ Kỹ Năng Kỹ Thuật Chuẩn Mực Cho Google Antigravity (Antigravity Skills Suite)

Kho lưu trữ này chứa **Bộ Ngũ Trụ Cột Kỹ Thuật (The Five Pillars)** được thiết kế chuyên biệt cho Google Antigravity để tái sử dụng vĩnh viễn trên mọi dự án phần mềm Desktop (Tauri/Electron/Qt) và Website (React/Next.js/Vue):

---

## 🏛️ Bộ Ngũ Trụ Cột Kỹ Thuật (The Five Pillars)

```mermaid
graph TD
    Pillar1["1. Explicit Confirmation Gate<br/>(Cổng Kiểm Soát Hành Vi)"]
    Pillar2["2. QA Verification<br/>(Cổng Kiểm Định Chất Lượng 5 Tầng)"]
    Pillar3["3. Modular Architecture<br/>(Kiến Trúc Module Hóa)"]
    Pillar4["4. Spec-Driven Dev<br/>(Đặc Tả & Mỏ Neo Đĩa Cứng)"]
    Pillar5["5. UI Design System<br/>(Chuẩn Hóa Giao Diện)"]

    Pillar1 --> Core["PHẦN MỀM CHUYÊN NGHIỆP<br/>BỀN BỈ & ĐẲNG CẤP"]
    Pillar2 --> Core
    Pillar3 --> Core
    Pillar4 --> Core
    Pillar5 --> Core

    style Pillar1 fill:#fee2e2,stroke:#ef4444,stroke-width:2px;
    style Pillar2 fill:#dcfce7,stroke:#16a34a,stroke-width:2px;
    style Pillar3 fill:#dbeafe,stroke:#2563eb,stroke-width:2px;
    style Pillar4 fill:#fef3c7,stroke:#d97706,stroke-width:2px;
    style Pillar5 fill:#fce7f3,stroke:#db2777,stroke-width:2px;
    style Core fill:#f8fafc,stroke:#0f172a,stroke-width:3px;
```

---

### 1. [`explicit-confirmation-gate/SKILL.md`](./explicit-confirmation-gate/SKILL.md)
* **Mục tiêu**: Đảm bảo quyền kiểm soát tuyệt đối của con người đối với mã nguồn (Human-in-the-loop).
* **Quy tắc vàng**:
  * Khi người dùng yêu cầu: *Lên kế hoạch, làm mockup, khảo sát, tư vấn...* $\rightarrow$ AI **CHỈ ĐƯỢC PHÉP** tạo kế hoạch/mockup và **DỪNG LẠI CHỜ DUYỆT**.
  * AI **TUYỆT ĐỐI CẤM** tự ý sửa code khi chưa có xác nhận bằng văn bản trực tiếp từ người dùng.
  * Bỏ qua hoàn toàn thông báo tự động `Stop hook blocked termination` của IDE.

---

### 2. [`qa-verification/SKILL.md`](./qa-verification/SKILL.md)
* **Mục tiêu**: Quy trình kiểm thử toàn diện, đảm bảo tính đúng đắn 100% của phần mềm trước khi bàn giao cho người dùng.
* **Quy tắc vàng**: 
  1. Áp dụng Kim tự tháp Kiểm thử 5 tầng (Tầng 0 Modular Gate $\rightarrow$ Unit $\rightarrow$ Integration $\rightarrow$ E2E/UI $\rightarrow$ Regression).
  2. Bắt buộc kiểm thử đích danh theo tính năng (Feature-Specific Test Verification).
  3. Bảo vệ dữ liệu người dùng (Quantity Protection & Anti-Overwrite): Nhập lại file cũ không bao giờ làm mất số liệu đã duyệt.
  4. Xử lý dữ liệu bẩn: Tự động dọn dẹp các chuỗi `null`, `none`, `nan`, lỗi chính tả, ngày tháng lệch chuẩn.
  5. Cấm đóng gói `.exe` hoặc `build` khi chưa pass 100% test cases.

---

### 3. [`modular-architecture/SKILL.md`](./modular-architecture/SKILL.md)
* **Mục tiêu**: Đảm bảo toàn bộ dự án luôn được chia thành các phân hệ độc lập (Feature-Based Modules).
* **Quy tắc vàng**: Khi sửa hoặc nâng cấp một tính năng cũ, hoặc làm thêm tính năng mới, **vĩnh viễn không bao giờ ảnh hưởng tới các tính năng khác (Zero-Regression)**.
* **Cấu trúc**: Mỗi tính năng sở hữu thư mục riêng gồm `components/`, `hooks/`, `rules.ts` và chỉ giao tiếp ra ngoài qua Public API `index.ts`. Cấm ký sinh tính năng (Trojan Horse Anti-Pattern) và cấm import sâu.

---

### 4. [`spec-driven-development/SKILL.md`](./spec-driven-development/SKILL.md)
* **Mục tiêu**: Giải quyết triệt để vấn đề AI quên kế hoạch ban đầu, trôi ngữ cảnh khi dự án lớn kéo dài, và thiếu sót tính năng khi thực thi.
* **Quy tắc vàng**:
  1. **Kiến trúc phân tầng 4 lớp**: Tách bạch giữa Master Roadmap (`docs/specs/ROADMAP.md`), Đặc tả chi tiết từng tính năng (`SPEC.md`), Living Task Checklist (`TASKS.md`), và Cổng thực thi cuốn chiếu (Phase-Gated Execution).
  2. **Mỏ neo đĩa cứng (Disk-Anchored Memory)**: Lưu trạng thái `[ ]`, `[/]`, `[x]` trực tiếp trên file đĩa cứng. Đọc mỏ neo ở đầu mỗi phiên và cập nhật mỏ neo ngay sau mỗi task hoàn thành.
  3. **Thực thi cuốn chiếu (Single-Piece Flow)**: Làm dứt điểm từng phân hệ, hoàn thành 100% kiểm thử và nghiệm thu trước khi chuyển sang phân hệ tiếp theo.
  4. **Chính sách Spec-First**: Mọi thay đổi yêu cầu giữa chừng phải được ghi vào `SPEC.md` trước khi chạm vào mã nguồn.

---

### 5. [`ui-design-system/SKILL.md`](./ui-design-system/SKILL.md)
* **Mục tiêu**: Chuẩn hóa toàn diện phong cách thẩm mỹ, trải nghiệm người dùng (UI/UX), bộ Design Tokens, bất biến Zero-Raw-HTML và bắt buộc lập đặc tả hệ thống thiết kế trước khi viết code.
* **Quy tắc vàng**:
  1. **Cổng đặc tả trước khi code (Pre-Code Design System Specification Gate)**: Trước khi viết dòng code đầu tiên, AI **BẮT BUỘC PHẢI TẠO FILE DESIGN SYSTEM SPECIFICATION** và tệp **Mockup tương tác**, sau đó xuất trình và **CHỜ NGƯỜI DÙNG DUYỆT TRỰC TIẾP** mới được bắt đầu lập trình.
  2. **Bất biến Zero-Raw-HTML (Zero-Raw-HTML Invariance)**: 100% phần tử giao diện phải nhập khẩu từ `@/components/ui`. Tuyệt đối cấm viết thẻ HTML thô (`<input>`, `<select>`, `<button>`, raw dashed `<div>`).
  3. **Chuẩn hóa cấp dự án (Project-Level Standardization)**: Mỗi dự án sở hữu bộ component chuẩn độc lập tại `@/components/ui`, nhiều dự án chạy song song không bao giờ xung đột thiết kế.
  4. **Cổng phê duyệt thiết kế lần đầu (First-Design Approval Gate)**: Khi component mới xuất hiện, AI bắt buộc phải hỏi người dùng có muốn lấy làm chuẩn cho toàn dự án hay không.

---

## 🚀 HƯỚNG DẪN CÀI ĐẶT NHANH SANG MÁY TÍNH MỚI

### Cách 1: Cài đặt tự động bằng 1-Click (Khuyến nghị cho Windows)
1. Tải về hoặc giải nén thư mục này trên máy tính của bạn.
2. Click đúp chuột vào file **`install.bat`** (hoặc chạy lệnh: `powershell -ExecutionPolicy Bypass -File install.ps1`).
3. Chọn chế độ cài đặt:
   - **Phím 1**: Cài đặt 3 Skill cốt lõi (`explicit-confirmation-gate`, `qa-verification`, `modular-architecture`).
   - **Phím 2** *(Mặc định - Khuyến nghị)*: Cài đặt toàn bộ 5 Skill chuẩn mực đầy đủ.
4. Xong! Toàn bộ Skill sẽ được tự động cài chính xác vào `%USERPROFILE%\.gemini\config\skills\`.

### Cách 2: Cài đặt bằng Git Clone (Nhanh nhất cho lập trình viên)
Mở Terminal/PowerShell và chạy lệnh:
```bash
git clone https://github.com/tahiep2012/MyAntigravitySkill.git "$env:USERPROFILE\.gemini\config\skills\antigravity-suite"
```
Hoặc clone về thư mục tạm rồi chạy file `install.bat`.

---

## 🗑️ GỠ CÀI ĐẶT

Nếu muốn gỡ bỏ các skill này khỏi Antigravity, chỉ cần chạy script:
```powershell
powershell -ExecutionPolicy Bypass -File uninstall.ps1
```
