# Nguyên Tắc Kiến Trúc & SOLID Trong Ứng Dụng Module Hoá

Tài liệu này giải thích chi tiết các nguyên tắc kiến trúc phần mềm được áp dụng để đảm bảo tính module hoá cao và không bao giờ gây lỗi chéo (Zero Regression).

---

## 1. Nguyên Tắc Đơn Nhiệm (Single Responsibility Principle - SRP)
- **Định nghĩa**: Một module, component hoặc hook chỉ nên có một lý do duy nhất để thay đổi.
- **Áp dụng**:
  - `OrdersTable.tsx`: Chỉ chịu trách nhiệm hiển thị lưới dữ liệu đơn hàng và kích hoạt sự kiện người dùng (click, double click).
  - `useTableSelection.ts`: Chỉ chịu trách nhiệm lưu trữ và tính toán tập hợp các dòng được chọn (`selectedUids`), không quan tâm dữ liệu đơn hàng được tải từ đâu.
  - `useColumnResize.ts`: Chỉ tính toán kích thước pixel của các cột khi kéo rê chuột.
  - `api.ts`: Chỉ đóng gói các lệnh gọi IPC/SQLite tới Backend, không chứa logic render giao diện.

---

## 2. Nguyên Tắc Đóng/Mở (Open/Closed Principle - OCP)
- **Định nghĩa**: Một module phải **mở để mở rộng (Open for extension)** nhưng **đóng để sửa đổi (Closed for modification)**.
- **Áp dụng**:
  - Khi thêm một tab mới vào màn hình Cài Đặt (`SettingsView`), ta chỉ cần thêm một đối tượng vào danh sách `SETTINGS_TABS` và render Component mới:
    ```tsx
    const SETTINGS_TABS = [
      { id: 'database', label: 'Cơ sở dữ liệu', component: DatabaseSection },
      { id: 'columns', label: 'Cài đặt Cột', component: ColumnSettingsSection },
      { id: 'shortcuts', label: 'Phím Tắt', component: ShortcutsSettingsSection },
      // Thêm tab mới tại đây mà không cần sửa cấu trúc Sidebar hoặc viết lại toàn bộ SettingsView!
    ];
    ```
  - Khi thêm cột mới vào bảng đơn hàng, chỉ cần khai báo thêm cấu hình trong `columns.ts`, bảng dữ liệu sẽ tự động hiểu và vẽ thêm cột mới mà không cần can thiệp vào `OrdersTable.tsx`.

---

## 3. Nguyên Tắc Phân Tách Giao Diện (Interface Segregation Principle - ISP)
- **Định nghĩa**: Các component con không nên bị ép phụ thuộc vào các prop hay interface mà chúng không sử dụng.
- **Áp dụng**:
  - Không truyền toàn bộ object `orders` khổng lồ vào những component chỉ cần `totalCount` hoặc `selectedCount`.
  - Giữ Props interface của từng sub-component tinh gọn và rõ ràng.

---

## 4. Ghép Nối Lỏng & Độc Lập Hoàn Toàn (Loose Coupling)
- Không có bất kỳ module tính năng nào được phép import trực tiếp file nội bộ của module tính năng khác.
- **Sai**:
  ```ts
  // TRONG warehouse/WarehouseView.tsx:
  import { somePrivateHelper } from '../orders/components/OrdersTable'; // VI PHẠM!
  ```
- **Đúng**:
  - Đưa helper dùng chung lên tầng `src/utils/` hoặc định nghĩa kiểu dữ liệu tại `src/types/`.
  - Giao tiếp dữ liệu qua Props hoặc Custom Events.
