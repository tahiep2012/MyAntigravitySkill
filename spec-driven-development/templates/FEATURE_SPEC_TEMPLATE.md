# ĐẶC TẢ TÍNH NĂNG CHI TIẾT (FEATURE SPECIFICATION)

> **Mã Epic**: `EPIC-XX`  
> **Tên Tính Năng**: `[Tên tính năng ngắn gọn, rõ ràng]`  
> **Phân Hệ Trực Thuộc**: `[Tên phân hệ cha, ví dụ: Order Management, Warehouse, RPA...]`  
> **Trạng Thái Hiện Tại**: `[DRAFT | REVIEWED | IN_PROGRESS | COMPLETED]`  
> **Người Soạn Thảo**: `[Tác giả / AI Agent]`  
> **Ngày Lập**: `YYYY-MM-DD` | **Cập Nhật Lần Cuối**: `YYYY-MM-DD`  

---

## 1. Tổng Quan & Câu Chuyện Người Dùng (Overview & User Stories)

### 1.1. Bối cảnh & Giá trị mang lại (Context & Value)
- Tại sao người dùng cần tính năng này?
- Giá trị tiết kiệm thời gian hoặc hạn chế sai sót thực tế là gì?

### 1.2. Câu chuyện người dùng (User Stories)
- **Là** một: `[Vai trò người dùng: Nhân viên mua hàng / Quản trị viên / Thủ kho...]`
- **Tôi muốn**: `[Thực hiện hành động gì: Xem danh sách đơn / Lọc cột nâng cao / Xuất file RPA...]`
- **Để**: `[Đạt mục tiêu gì: Đối soát thanh toán nhanh chóng / Không bị nhập trùng...]`

### 1.3. Phạm vi tính năng (Scope)
- **Nằm trong phạm vi (In-Scope)**:
  - Điểm 1: ...
  - Điểm 2: ...
- **Nằm ngoài phạm vi (Out-of-Scope - Không làm trong Phase này)**:
  - Điểm 1: Sẽ triển khai ở `EPIC-YY`...

---

## 2. Ranh Giới Mô-Đun & Kiến Trúc (Modular Boundaries)

> [!CAUTION]
> Tuân thủ nghiêm ngặt kỹ năng `modular-architecture`. Cấm viết code ký sinh, cấm gọi trực tiếp file nội bộ của phân hệ khác.

### 2.1. Cấu trúc thư mục mã nguồn dự kiến
```text
src/modules/[feature-name]/
├── components/
│   ├── [FeatureMainComponent].tsx    # Component giao diện chính
│   └── [FeatureSubComponent].tsx     # Component con
├── hooks/
│   ├── use[FeatureName].ts           # Hook quản lý state và nghiệp vụ
│   └── use[FeatureFilter].ts         # Hook lọc, tìm kiếm
├── types.ts                          # Định nghĩa TypeScript interface nội bộ
├── rules.ts                          # Công thức tính toán và quy tắc nghiệp vụ thuần túy
└── index.ts                          # Public API DUY NHẤT xuất ra bên ngoài
```

### 2.2. Điểm tích hợp Backend (Backend / Rust Tauri Commands)
- **File Backend**: `src-tauri/src/[feature_name].rs` (Module Rust độc lập)
- **Các lệnh IPC dự kiến**:
  - `fn get_[feature]_data(...) -> Result<Vec<...>, String>`
  - `fn save_[feature]_item(...) -> Result<..., String>`
- **Đăng ký module**: Khai báo trong `src-tauri/src/main.rs` qua `mod [feature_name];` và `generate_handler![]`.

---

## 3. Mô Hình Dữ Liệu & CSDL (Data Model & Schema)

### 3.1. Bảng CSDL SQLite (Tables & Indices)
```sql
CREATE TABLE IF NOT EXISTS [table_name] (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uid TEXT UNIQUE NOT NULL,
    [field_1] TEXT NOT NULL,
    [field_2] REAL DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_[table_name]_[field_1] ON [table_name] ([field_1]);
```

### 3.2. Kiểu dữ liệu TypeScript Interface
```typescript
export interface [FeatureItem] {
  id: number;
  uid: string;
  field1: string;
  field2: number;
  createdAt: string;
  updatedAt: string;
}
```

---

## 4. Đặc Tả Giao Diện & Máy Trạng Thái UI (UI Specifications & 4 States)

> [!IMPORTANT]
> Tuân thủ kỹ năng `ui-design-system`: Tái sử dụng Atomic Components (`Button`, `SearchInput`, `Card`, `Badge`, `Modal`). Đảm bảo đủ 4 trạng thái giao diện.

### 4.1. Bản mô tả bố cục (Layout & Controls)
- **Thanh công cụ (Toolbar)**:
  - Ô tìm kiếm nhanh (`SearchInput` với phím tắt `/` hoặc `Ctrl+F`).
  - Nút thêm mới / xuất file (`Button` với icon Lucide phù hợp).
- **Khu vực hiển thị chính**:
  - Bảng dữ liệu hoặc thẻ thẻ (Cards).
- **Phím tắt hỗ trợ (Keyboard Shortcuts)**:
  - `Alt + C`: Xóa bộ lọc hiện tại.
  - `Shift + D`: [Hành động chuyên biệt].
  - `Esc`: Đóng popup / modal.

### 4.2. Máy 4 trạng thái giao diện bắt buộc (The 4 UI States)
1. **Trạng thái Đang Tải (`Loading State`)**:
   - Hiển thị Skeleton Loader hoặc spinner bo tròn thanh lịch (`animate-pulse`).
   - Khóa các nút tương tác để ngăn chặn người dùng bấm liên tục (Double submission).
2. **Trạng thái Trống Dữ Liệu (`Empty State`)**:
   - Khi chưa có bản ghi: Hiển thị minh họa rõ ràng, thông điệp thân thiện và nút hành động gợi ý (*"Chưa có đơn hàng nào. Bấm 'Nhập Excel' để bắt đầu"*).
   - Khi lọc không thấy kết quả: Hiển thị *"Không tìm thấy kết quả phù hợp với bộ lọc"* kèm nút *"Xóa bộ lọc"*.
3. **Trạng thái Báo Lỗi (`Error State`)**:
   - Khi truy vấn SQLite hoặc gọi backend thất bại: Hiển thị Banner lỗi màu đỏ dịu (`bg-rose-50 border-rose-200 text-rose-700`).
   - Có nút *"Thử lại (Retry)"* và hiển thị mã lỗi kỹ thuật có thể copy.
4. **Trạng thái Thành Công & Bình Thường (`Success / Idle State`)**:
   - Hiển thị dữ liệu đầy đủ, phân trang mượt mà, định dạng tiền tệ/ngày tháng đồng nhất.

---

## 5. Quy Tắc Nghiệp Vụ & Thuật Toán (Business Rules & Formulas)

1. **Quy tắc phân loại & tính toán**:
   - Công thức: `[Tổng giá trị = Số lượng * Đơn giá * (1 + Thuế VAT)]`
   - Điều kiện làm tròn số: Quy chuẩn làm tròn 2 chữ số thập phân, tiền tệ làm tròn theo đơn vị đồng.
2. **Quy tắc sắp xếp & lọc**:
   - Danh sách giá trị lọc cột: Giá trị `(TRỐNG)` luôn luôn được đưa lên dòng đầu tiên.
   - Thứ tự hiển thị mặc định: Sắp xếp theo ngày tạo giảm dần hoặc theo thứ tự người dùng tùy chọn.
3. **Quy tắc bảo vệ dữ liệu (Data Integrity Protection)**:
   - Khi import lại file dữ liệu cũ, không được ghi đè các trường đã được người dùng chỉnh sửa thủ công.

---

## 6. Xử Lý Biên & Dữ Liệu Bẩn (Edge Cases & Dirty Data Resilience)

Tuân thủ nghiêm ngặt `qa-verification` đối với các trường hợp dữ liệu bất thường:

| Tình Huống Biên (Edge Case) | Hành Vi Dự Kiến Chuẩn |
| :--- | :--- |
| **Giá trị Null / Undefined / Chuỗi rỗng** | Tự động chuyển đổi về giá trị mặc định an toàn (`""` hoặc `0`), không văng crash màn hình trắng (White Screen of Death). |
| **Ký tự đặc biệt & Dấu phẩy / Dấu chấm** | Chuẩn hóa dấu phân cách thập phân kiểu Việt Nam (`1.000,50`) và quốc tế (`1,000.50`). Xử lý an toàn chuỗi SQL injection / XSS. |
| **Số lượng bản ghi khổng lồ (> 10,000 dòng)** | Sử dụng ảo hóa (Virtualization) hoặc phân trang (Pagination) để giao diện không bị giật lag, giữ FPS $\ge 60$. |
| **Thao tác nhanh / Bấm liên tục (Debounce / Throttle)** | Debounce ô tìm kiếm 300ms; vô hiệu hóa nút submit ngay khi vừa bấm. |

---

## 7. Tiêu Chí Nghiệm Thu (Acceptance Criteria / Definition of Done)

Một tính năng chỉ được xem là hoàn tất khi thỏa mãn **100%** danh sách sau:
- [ ] **Mã nguồn chuẩn mực**: Không có cảnh báo lint/TypeScript compiler errors.
- [ ] **Độc lập kiến trúc**: Vượt qua bộ kiểm tra Tầng 0 Modular Architecture (`tests/test_qa_lifecycle.ts`).
- [ ] **Đầy đủ 4 trạng thái UI**: Đã kiểm tra trực quan Loading, Empty, Error, Success.
- [ ] **Bộ kiểm thử đích danh (Feature-Specific Tests)**: Đã viết các test cases kiểm thử trực tiếp tính năng này và pass 100%.
- [ ] **Tài liệu hoàn chỉnh**: Đã cập nhật file `TASKS.md` tương ứng thành `[x]` cho mọi hạng mục.
- [ ] **Xác nhận người dùng**: Người dùng đã trải nghiệm và xác nhận nghiệm thu.
