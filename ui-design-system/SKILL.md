---
name: ui-design-system
description: >-
  Enforces comprehensive UI/UX standardization, Design Tokens, atomic component reuse,
  and visual consistency across web and desktop applications. Use this skill whenever
  designing new screens, creating UI components, styling layouts, or reviewing frontend code
  to ensure 100% aesthetic coherence and professional polish.
---

# UI Design System & Visual Standardization Skill

This skill guides the AI agent and developers in establishing and maintaining **100% UI Consistency** across all pages, dialogs, components, and interactive elements of an application.

---

## 1. Core Mandates (Quy Tắc Bắt Buộc)

1. **Component-First Discipline (Cấm tự viết thẻ raw html tùy tiện trong React)**:
   - ❌ **TUYỆT ĐỐI CẤM**: Tự tiện viết `<button className="...">`, `<input className="...">`, `<select className="...">` với class ad-hoc rời rạc trong mã nguồn ứng dụng.
   - ✅ **BẮT BUỘC**: Tái sử dụng 100% Atomic Components từ `@/components/ui`:
     - `<Button variant="..." size="..." icon={...}>`
     - `<SearchInput value={...} onChange={...} />`
     - `<Input label="..." error="..." {...props} />`
     - `<Badge variant="...">`
     - `<Card variant="..." rounded="...">`, `<CardHeader>`, `<CardContent>`
     - `<PageHeader title="..." description="..." actions={...} />`
     - `<Modal isOpen={...} onClose={...} title="..." icon={...}>`

2. **Semantic Design Tokens (Dùng biến token ngữ nghĩa chuẩn)**:
   - Sử dụng màu ngữ nghĩa: `blue-600` (brand/primary), `emerald-600` (success), `rose-600` (danger/delete), `amber-500` (warning), `slate-500` (captions/neutral).
   - Tuyệt đối KHÔNG chế mã hex màu tùy tiện (`#123abc`) hoặc đưa màu sắc lạc điệu (như màu tím, cam rực rỡ không thuộc hệ thống) vào giao diện bảng dữ liệu.

3. **Harmonized Geometry & Spacing (Hệ thống khoảng cách & bo góc chuẩn)**:
   - **Border Radius**:
     - `rounded-xl` (12px): Badges, inputs, compact buttons, dropdown items.
     - `rounded-2xl` (16px): Primary buttons, medium cards, popovers, selection action bars.
     - `rounded-3xl` (24px): Page cards, modal dialogs, main data containers.
   - **Spacing Grid**: Bội số của 4px (`p-1` = 4px, `p-2` = 8px, `p-3` = 12px, `p-4` = 16px, `p-5` = 20px, `p-6` = 24px).

4. **Screen Archetype Discipline (Phân biệt Bảng Dữ Liệu Chuyên Sâu vs Trang Tổng Quan)**:
   - **Loại 1: Data-Dense Table Views (Đơn hàng PO/OD, Kho hàng, Nhà cung cấp)**:
     - ❌ **TUYỆT ĐỐI CẤM**: Tự ý chèn Top Hero Banner gradient trang trí chiếm diện tích màn hình. Người dùng vận hành kho và thu mua cần tối đa hóa chiều cao nhìn thấy của bảng dữ liệu.
     - ✅ **BẮT BUỘC**: Tuân thủ cấu trúc phân cấp chuẩn của `OrdersView.tsx`:
       - **Toolbar Card** (`bg-white rounded-3xl p-4 border border-slate-200/80 shadow-xs space-y-3`):
         - Hàng 1: Tabs trạng thái nghiệp vụ dạng pill-tabs (`bg-slate-100/90 rounded-2xl`) kèm phím tắt (F1-F4) và badge số lượng + Smart Sort + Zoom controls + Refresh button.
         - Hàng 2: Nút Tìm Nhanh (Shift+F), Cài đặt cột, và Dải thao tác hàng loạt (`bg-blue-50/90 border border-blue-200/80 rounded-2xl`) tự động hiện khi chọn dòng.
       - **Table Card** (`bg-white rounded-3xl border border-slate-200/80 shadow-xs flex-1 min-h-0`):
         - Thanh chỉ dẫn đầu bảng (`h-10 bg-slate-50/70 border-b border-slate-100`) với **3 chấm tròn màu sắc chuẩn**: Tím Indigo (`bg-indigo-500` - kéo mép cột), Xanh dương (`bg-blue-500` - chọn nhiều dòng), Xanh lá (`bg-emerald-500` - sửa ô/xem thẻ).
         - Thead dính `sticky top-0 bg-slate-100/95 backdrop-blur-xs text-[11px] font-bold text-slate-600 uppercase tracking-wider border-b border-slate-200/90`.
         - Dòng chọn (Selected Row): Nền xanh nhạt `bg-blue-50/70`, chữ đậm `font-medium text-slate-900`, và vạch chỉ báo mép trái `border-l-4 border-l-blue-600`.
         - Dòng không chọn: `hover:bg-blue-50/40 even:bg-slate-50/40 text-slate-700 border-l-4 border-l-transparent`.
         - Chân bảng: Phân trang chuẩn và dải tóm tắt tổng số lượng then chốt.
   - **Loại 2: Overview / Analytics Views (Dashboard)**: Cho phép sử dụng Hero Banner chào mừng hoặc thẻ KPI tổng hợp.

5. **Batch Grid Modal Mandate (Chuẩn Hóa Hộp Thoại Xử Lý Hàng Loạt)**:
   - Khi phát sinh nghiệp vụ tác động nhiều dòng (như Nhận hàng & HĐ, Nhập kho loạt, Xuất kho loạt):
     - ❌ **CẤM**: Tạo popup đơn lẻ xử lý từng dòng gây thao tác lặp đi lặp lại tốn thời gian.
     - ✅ **BẮT BUỘC**: Sử dụng Modal dạng Bảng lưới rộng `max-w-6xl` mô phỏng 1:1 theo `DeliverySettlementModal.tsx`:
       - Header: Nền gradient tinh tế `from-blue-50 via-indigo-50/40 to-slate-50`, icon trong hộp `w-10 h-10 rounded-2xl bg-blue-600 text-white shadow-md shadow-blue-600/20`.
       - Khối thông tin chung: `bg-slate-50 rounded-2xl border border-slate-200/80 p-4` (ngày thực hiện, số chứng từ, vị trí kho/bộ phận nhận, ghi chú).
       - Bảng lưới chi tiết: Thao tác nhập số lượng từng dòng, có nút hành động nhanh "⚡ Điền đủ 100%".
       - Anti-Negative Stock Guard: Với nghiệp vụ xuất kho, tự động so sánh số lượng xuất với tồn kho thực tế; nếu vượt quá tồn kho phải đổi viền đỏ `border-rose-500 bg-rose-50`, báo lỗi âm kho và khóa nút Lưu.
       - Dải tổng hợp chân modal: `bg-blue-50/80 border border-blue-200 rounded-2xl p-3.5`.
       - Footer: Nút Hủy `bg-white border-slate-200 text-slate-700`, Nút Lưu `bg-blue-600 hover:bg-blue-700 text-white rounded-xl font-bold shadow-xs`.

6. **Offline-First Mockup Mandate (Chuẩn Mockup HTML Ngoại Tuyến 100%)**:
   - Khi tạo file Mockup tĩnh trong thư mục `mockup/*.html` để trình diễn cho người dùng duyệt theo `explicit-confirmation-gate`:
     - ❌ **TUYỆT ĐỐI CẤM**: Nhúng bất kỳ đường dẫn CDN trực tuyến nào (`https://cdn.tailwindcss.com`, `cdnjs`, Google Fonts qua mạng). Mạng nội bộ doanh nghiệp/intranet sẽ chặn hoặc timeout các link này làm vỡ nát giao diện thành văn bản đen trắng thô sơ.
     - ✅ **BẮT BUỘC**: File mockup HTML phải hoàn toàn **Offline-First**, tự chứa 100% CSS quy chuẩn (Self-Contained Embedded CSS) hoặc link tới file CSS nội bộ `dist/assets/`, và nhúng SVG Lucide icons trực tiếp (inline SVG).
     - ✅ **BẮT BUỘC**: Trước khi tạo mockup, AI PHẢI đọc trực tiếp các view hiện hữu (`OrdersToolbar.tsx`, `OrdersTable.tsx`) làm **Vật Chuẩn Quy Chiếu (Anchor Reference)** để sao chép chuẩn xác từng mã màu, class bo góc, và cấu trúc layout.

7. **The 4 Essential Data States (Đủ 4 trạng thái dữ liệu)**:
   - Mọi bảng dữ liệu, danh sách và modal tương tác bắt buộc phải hỗ trợ đủ 4 trạng thái:
     1. **Loading State**: Skeleton hoặc spinner tải dữ liệu mượt mà.
     2. **Empty State**: Minh họa trực quan khi chưa có dữ liệu kèm nút hành động.
     3. **Error State**: Thông báo lỗi rõ ràng kèm nút thử lại (`Retry`).
     4. **Success State**: Dữ liệu hiển thị chuẩn mực kèm phân trang/cuộn mượt.

8. **Unified Iconography**:
   - Chỉ sử dụng Lucide icons (`lucide-react` hoặc inline SVG tương đương).
   - Kích thước chuẩn: `w-3.5 h-3.5` (compact), `w-4 h-4` (standard), `w-5 h-5` (headers).

---

## 2. Standard Page Blueprint (Khung Mẫu Trang Chuẩn)

### Mẫu 1: Data-Dense Table View (Dành cho Đơn hàng, Kho bãi, Danh mục)
```tsx
import React, { useState } from 'react';
import { Package, Search, RefreshCw, ZoomIn, ZoomOut } from 'lucide-react';

export const MyStandardTableView: React.FC = () => {
  const [activeTab, setActiveTab] = useState('ALL');

  return (
    <div className="flex flex-col gap-3 h-full flex-1 w-full min-h-0">
      {/* 1. Toolbar Card (Bo tròn rounded-3xl) */}
      <div className="bg-white rounded-3xl p-4 border border-slate-200/80 shadow-xs space-y-3 shrink-0">
        <div className="flex items-center justify-between gap-3">
          {/* Pill Tabs */}
          <div className="flex items-center gap-1 p-1 bg-slate-100/90 rounded-2xl">
            <button className="px-3 py-1.5 rounded-xl text-xs font-bold bg-blue-600 text-white shadow-md shadow-blue-600/20">
              Tất cả
            </button>
          </div>
          {/* Right Controls */}
          <div className="flex items-center gap-2">
            <button className="p-2 text-slate-600 hover:text-blue-600 hover:bg-blue-50 rounded-xl transition-colors">
              <RefreshCw className="w-4 h-4" />
            </button>
          </div>
        </div>
      </div>

      {/* 2. Main Table Card */}
      <div className="bg-white rounded-3xl border border-slate-200/80 shadow-xs overflow-hidden flex flex-col flex-1 w-full min-h-0">
        {/* Table Guide Header */}
        <div className="h-10 px-3 border-b border-slate-100 flex items-center justify-between text-xs font-semibold text-slate-500 bg-slate-50/70 shrink-0">
          <span>Đang xem: 1 – 300 dòng</span>
          <div className="flex items-center gap-3 text-[11px] text-slate-400">
            <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-indigo-500" /> Kéo cột</span>
            <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-blue-500" /> Chọn dòng</span>
            <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-emerald-500" /> Sửa ô</span>
          </div>
        </div>
        {/* Scrollable Table Content */}
        <div className="flex-1 overflow-auto">
          {/* Table content goes here */}
        </div>
      </div>
    </div>
  );
};
```

---

## 3. CỔNG CHẶN KIỂM THỬ GIAO DIỆN TỰ ĐỘNG (AUTOMATED UI TEST GATE)

- **Liên kết với `qa-verification`**:
  - Bộ kiểm thử tự động `tests/test_qa_lifecycle.ts` (Tầng 3) quét toàn bộ mã nguồn của các module mới và thư mục `mockup/`:
    1. **Quét Component React**: Bắt buộc dùng Atomic Components từ `@/components/ui`, cấm viết thẻ raw `<button className="...">` với class ad-hoc.
    2. **Quét Mockup HTML**: Quét cấm triệt để link CDN online (`cdn.tailwindcss.com`, `cdnjs`), kiểm tra tính toàn vẹn Offline-First.
    3. **Quét Semantic Tokens**: Quét bắt lỗi mã màu lạ ngoài hệ thống Design Token (như nút màu tím ngoài luồng, hex tùy tiện).
  - Nếu phát hiện vi phạm: $\rightarrow$ **Test suite sẽ báo FAIL ngay lập tức và chặn đứng việc build/đóng gói ứng dụng**.

---

## 4. Reference Documentation

- [Design Tokens Specification](./references/design_tokens.md)
- [Component Specifications & Props](./references/component_specs.md)
- [UI/UX Quality Audit Checklist](./references/ui_ux_checklist.md)
- [Standard Page Template](./examples/StandardPageTemplate.tsx)
- [Component Usage Guide](./examples/ComponentUsageGuide.tsx)
- [UI Consistency Audit Script](./scripts/audit_ui_consistency.ps1)
