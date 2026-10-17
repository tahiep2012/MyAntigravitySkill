# DESIGN SYSTEM SPECIFICATION: [TÊN DỰ ÁN]

> **Trạng thái**: Chờ duyệt (Pending Approval) / Đã duyệt (Approved)  
> **Phiên bản**: v1.0.0  
> **Cổng Kiến Trúc**: Tuân thủ `ui-design-system` & `explicit-confirmation-gate`  

---

## 1. Design Tokens (Nền Tảng Giao Diện)

### 1.1 Bảng Màu Ngữ Nghĩa (Semantic Color Palette)
* **Brand / Primary**: `#2563eb` (Blue-600), Hover: `#1d4ed8` (Blue-700), Light: `#eff6ff` (Blue-50).
* **Success**: `#059669` (Emerald-600), Light: `#ecfdf5` (Emerald-50).
* **Warning**: `#f59e0b` (Amber-500), Light: `#fffbeb` (Amber-50).
* **Danger**: `#e11d48` (Rose-600), Light: `#fff1f2` (Rose-50).
* **Neutral / Slate**: Background: `#f8fafc` (Slate-50), Border: `#e2e8f0` (Slate-200), Text: `#0f172a` (Slate-900).

### 1.2 Kiểu Chữ (Typography Scale)
* Font chữ giao diện: Inter / San Francisco / Roboto (`sans-serif`).
* Font chuyên biệt (nếu có, e.g. Hanzi, Code): Noto Sans SC, Consolas (`monospace`).
* Scale: H1 (28px Bold), H2 (20px Bold), H3 (16px Bold), Body (13.5px Medium), Small (12px), Micro (10.5px).

### 1.3 Hệ Thống Bo Góc (Border Radius Hierarchy)
* `rounded-lg` (8px): Badge, icon button nhỏ.
* `rounded-xl` (12px): Standard Button, Input, Select, Switch, PillTabs.
* `rounded-2xl` (16px): SearchInput, Card, Container chính.
* `rounded-3xl` (24px): Cửa sổ Popup, Modal Dialogs.

### 1.4 Đổ Bóng (Elevation & Shadows)
* `shadow-xs`: 0 1px 2px rgba(0,0,0,0.05) - Cho card và input.
* `shadow-hud`: 0 16px 36px rgba(15,23,42,0.2) - Cho popup nổi khối độc lập.

---

## 2. Component Inventory & Matrix (Danh Mục Thành Phần Chuẩn)

Tất cả component bắt buộc đóng gói tại `@/components/ui`:

| Component | Tệp tin | Quy chuẩn kích thước | Các biến thể (Variants) | Trạng thái (States) |
| :--- | :--- | :--- | :--- | :--- |
| **`SearchInput`** | `SearchInput.tsx` | Cao **48px**, `rounded-2xl` | Default, withActionButton, withClearBtn | Normal, Focus, Filled, Disabled |
| **`Button`** | `Button.tsx` | Cao 32px (`sm`), 40px (`md`), 48px (`lg`) | Primary, Secondary, Outline, Danger, Success, Ghost | Normal, Hover, Active, Loading, Disabled |
| **`IconButton`** | `IconButton.tsx` | Vuông **32x32px** (`rounded-xl`) | Ghost, Danger, Bordered, Primary, Light | Normal, Hover, Active, Disabled |
| **`Input`** | `Input.tsx` | Cao 36px (`sm`), 44px (`md`) | Default, withIconLeft, withIconRight | Normal, Focus, Error, Disabled |
| **`Select`** | `Select.tsx` | Cao **44px**, `rounded-xl` | Default, withOptGroup | Normal, Hover, Focus, Disabled |
| **`Switch`** | `Switch.tsx` | Rộng 44px x Cao 24px | Blue, Indigo, Emerald | Checked, Unchecked, Disabled |
| **`PillTabs`** | `PillTabs.tsx` | Dạng viên thuốc nổi khối | Sm, Md, withIcons, withBadges | Tab Active, Tab Inactive |
| **`Card`** | `Card.tsx` | Bo góc `rounded-2xl` | Default, Flat, Bordered, Dashed, Hud | Normal, Hoverable |
| **`Badge`** | `Badge.tsx` | Bo góc `rounded-xl` / pill | Primary, Success, Warning, Purple, Neutral | Sm, Md, withDot |
| **`EmptyState`** | `EmptyState.tsx` | Viền nét đứt `border-dashed` | Slate, Amber, Blue, Emerald, Rose | withCTA, withoutCTA |
| **`Modal`** | `Modal.tsx` | Nền mờ `backdrop-blur-xs` | Dialog, Confirmation, Drawer | Open, Closed |

---

## 3. API & Data Contract (Hợp Đồng Dữ Liệu UI)

Định nghĩa cấu trúc dữ liệu đầu vào và các sự kiện để Frontend dùng Mock Data và Backend xây dựng CSDL/API song song:

```typescript
// Ví dụ Interface hợp đồng dữ liệu cho màn hình chính:
export interface SearchQueryPayload {
  query: string;
  mode: 'exact' | 'fuzzy' | 'pinyin';
}

export interface SearchResultItem {
  id: string;
  title: string;
  subtitle?: string;
  badge?: string;
  metadata?: Record<string, any>;
}
```

---

## 4. Bản Mockup Tương Tác Sống (Interactive Showcase)
* Tệp HTML mô phỏng offline-first: `mockup/design_system_showcase.html`
* Cho phép người dùng và lãnh đạo click trải nghiệm toàn bộ tương tác trước khi phê duyệt.
