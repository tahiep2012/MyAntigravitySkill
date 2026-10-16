---
name: modular-architecture
description: >-
  Enforces strict feature-based modular architecture, high cohesion, low coupling,
  anti-parasitism isolation, and zero-regression boundaries across all codebases. Use this skill whenever designing,
  scaffolding a new project, adding a new feature, adding a button/action, or refactoring existing functionality
  to guarantee that features are never parasitic and other modules are never impacted.
---

# Modular Architecture & Anti-Parasitism Engineering Standard

This skill enforces **Strict Feature-Based Modular Architecture** and **Anti-Feature Parasitism (Chống Ký Sinh Tính Năng)**. It guarantees that any new feature, automation, export tool, or business logic is 100% encapsulated in its own dedicated module, preventing codebase bloat, spaghetti handlers, and hidden coupling.

---

## 1. ⚠️ THE "TROJAN HORSE" ANTI-PATTERN (BẪY NGỤY TRANG HÀNH ĐỘNG)

> [!CAUTION]
> **ĐÂY LÀ NGUYÊN NHÂN SỐ 1 KHIẾN AI VÀ DEVELOPER VI PHẠM MODULAR ARCHITECTURE:**
> Khi người dùng yêu cầu: *"Thêm nút [Hành Động X] vào thanh công cụ / bảng của [Phân Hệ Y]"*  
> (Ví dụ: *"Thêm nút Export RPA vào bảng Đã thanh toán"*, *"Thêm nút Kế hoạch chi vào Dashboard"*).
> 
> **AI AGENT TUYỆT ĐỐI CẤM**:
> 1. ❌ Coi đây chỉ là "chỉnh sửa nhỏ trên Phân Hệ Y".
> 2. ❌ Nhét hàm xử lý (handler, logic file, dialog, gọi API backend) trực tiếp vào `YView.tsx` hoặc `YToolbar.tsx`.
> 3. ❌ Nhét code xử lý backend vào file Rust của phân hệ cũ (ví dụ: nhét `export_rpa` vào `export_po.rs`).
>
> **QUY TẮC BẮT BUỘC (MANDATORY INVARIANT)**:
> Mọi tính năng thuộc các nhóm sau **BẮT BUỘC PHẢI TẠO MODULE ĐỘC LẬP MỚI (`src/modules/<feature>/`)**:
> - **Xuất / Nhập tự động hóa bên ngoài** (RPA, Power Automate Desktop, bot tích hợp, EDI, SAP).
> - **Báo cáo & Kế hoạch chuyên biệt** (Kế hoạch chi tiêu, dự báo dòng tiền, báo cáo SLA).
> - **Công cụ tra cứu & tiện ích sâu** (Search toàn cục `Ctrl+F`, tra cứu nhanh `Shift+F`, clipboard formatters).
> - **Tương tác kho & thẻ kho** (Stock cards, điều chuyển kho).
>
> **CƠ CHẾ KẾT NỐI HỢP LỆ DUY NHẤT VỚI PHÂN HỆ Y**:
> - Tạo module `src/modules/<feature>/` chứa component (ví dụ: `<Feature>Button.tsx`), hook (`use<Feature>.ts`) và `index.ts`.
> - Phân hệ Y **CHỈ ĐƯỢC PHÉP IMPORT COMPONENT NÀY QUA PUBLIC API `index.ts`** và đặt vào Toolbar.
> - Phân hệ Y **KHÔNG ĐƯỢC CHỨA BẤT KỲ DÒNG LOGIC NỘI BỘ NÀO** của tính năng đó!

---

## 2. BỘ TIÊU CHÍ PHÂN LOẠI "ACTION VS FEATURE" (MANDATORY DECISION MATRIX)

Trước khi chạm vào bất kỳ file nào trong dự án, AI Agent BẮT BUỘC phải đối chiếu bảng sau:

| Bản chất yêu cầu | Phân loại | Quy chuẩn kiến trúc bắt buộc |
| :--- | :--- | :--- |
| Đổi màu nút, đổi nhãn cột, sửa sắp xếp nội bộ của bảng | **Nội bộ Module** | Sửa trực tiếp trong module đó (`components/` hoặc `rules.ts`). |
| Thêm nút xuất file cho hệ thống thứ 3 (RPA, Excel mẫu riêng) | **MODULE ĐỘC LẬP** | Tạo `src/modules/<feature>/`, backend tạo file Rust riêng. |
| Thêm hộp thoại popup quy tắc / cấu hình nghiệp vụ mới | **MODULE ĐỘC LẬP** | Tạo `src/modules/<feature>/` độc lập, import qua `index.ts`. |
| Thêm tính năng sao chép tùy biến / chuyển đổi định dạng | **MODULE ĐỘC LẬP / HOOK CHUYÊN BIỆT** | Tách `hooks/` hoặc `utils/` chuyên biệt, export qua `index.ts`. |
| Tích hợp luồng phê duyệt / tự động hóa mới | **MODULE ĐỘC LẬP** | Tạo module độc lập, giao tiếp qua Event Bus hoặc Public Props. |

---

## 3. CẤU TRÚC CHUẨN CỦA MỘT MODULE ĐỘC LẬP

Mọi module độc lập trong `src/modules/<feature>/` phải tuân thủ chuẩn sau:

```text
src/modules/<feature_name>/
├── index.ts                  # ⭐ PUBLIC API DUY NHẤT (Mọi module khác chỉ import từ đây)
├── <Feature>View.tsx         # Màn hình chính (nếu là trang riêng)
├── components/               # Các UI component độc lập
│   ├── <Feature>Button.tsx   # Nút bấm tích hợp để phân hệ khác nhúng vào Toolbar
│   ├── <Feature>Modal.tsx    # Hộp thoại popup riêng của tính năng
│   └── <Feature>Table.tsx    # Bảng hiển thị riêng
├── hooks/                    # Logic tính toán, state, gọi Tauri IPC
│   ├── use<Feature>Data.ts
│   └── use<Feature>Actions.ts
└── rules.ts                  # Thuật toán thuần túy (Pure functions, 100% unit-testable)
```

### Quy chuẩn song song ở Backend Rust (`src-tauri/src/`):
- Mỗi module nghiệp vụ độc lập phải có file Rust tương ứng riêng biệt (ví dụ: `export_rpa.rs`, `payment_plan.rs`, `warehouse.rs`).
- Tuyệt đối **CẤM NHỒI NHÉT** code của tính năng mới vào các file đã có (`export_po.rs`, `db.rs`, `importer.rs`).
- `lib.rs` là nơi duy nhất khai báo `mod <feature>;` và đăng ký lệnh vào `generate_handler![]`.

---

## 4. PUBLIC API GATE & QUY TẮC BẢO VỆ RANH GIỚI

1. **Chỉ import từ `@/modules/<feature>` (qua `index.ts`)**:
   - ✅ Hợp lệ: `import { RpaExportButton } from '@/modules/rpa';`
   - ❌ BỊ CẤM: `import { RpaExportButton } from '@/modules/rpa/components/RpaExportButton';`
2. **Không ký sinh State**:
   - Component nhúng (ví dụ: `RpaExportButton`) chỉ nhận dữ liệu đầu vào cần thiết (như danh sách `orders` hoặc `selectedItems`) qua Props.
   - Toàn bộ logic gọi API, mở Save Dialog, hiển thị Toast, quản lý Loading State nằm trọn vẹn bên trong Hook của module đó.

---

## 5. QUY TRÌNH 5 BƯỚC BẮT BUỘC TRƯỚC KHI VIẾT CODE

Bất kỳ khi nào thực hiện nhiệm vụ thêm tính năng, AI Agent BẮT BUỘC phải thực hiện đủ 5 bước:

1. **Bước 1 - Định danh Domain**: Phân tích xem tính năng có phục vụ riêng cho một tác vụ độc lập (RPA, Kế hoạch chi, Báo cáo, Tra cứu...) không. Nếu có $\rightarrow$ Phải tạo Module mới!
2. **Bước 2 - Tạo cấu trúc thư mục**: Tạo `src/modules/<feature>/` với đầy đủ `index.ts`, `components/`, `hooks/`.
3. **Bước 3 - Triển khai lõi Backend & Frontend**: Viết file Rust riêng biệt trong `src-tauri/src/` và hook trong frontend.
4. **Bước 4 - Xuất khẩu Public API**: Đăng ký các component/hook cần dùng ra `index.ts`.
5. **Bước 5 - Nhúng vào giao diện bằng 1 dòng duy nhất**: Tại màn hình cha, chỉ import component đại diện từ `@/modules/<feature>` và đặt vào vị trí mong muốn.

---

## 6. CỔNG CHẶN KIỂM THỬ TỰ ĐỘNG (AUTOMATED TEST GATE)

- Mọi module mới **BẮT BUỘC PHẢI CÓ TEST CASES TƯƠNG ỨNG** trong `tests/test_qa_lifecycle.ts` (Tầng 0: Modular Architecture Gate).
- Bộ test Tầng 0 sẽ quét tự động:
  1. Kiểm tra tồn tại thư mục module và file `index.ts`.
  2. Kiểm tra cấm import sâu xuyên thấu.
  3. Kiểm tra rà soát các phân hệ chính (như `orders`, `dashboard`) không chứa các hàm xử lý ký sinh của bên thứ 3.
