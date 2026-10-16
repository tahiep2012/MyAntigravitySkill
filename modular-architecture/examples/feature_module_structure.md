# Mẫu Cấu Trúc Module Chuẩn (Feature Module Template)

Ví dụ chi tiết về cách tổ chức một module tính năng mới (Ví dụ: Module "Khách Hàng" - `customers`):

```text
src/modules/customers/
├── CustomersView.tsx             # Component chính (View Coordinator)
├── index.ts                      # Xuất khẩu công khai
├── customerRules.ts              # Thuật toán tính toán điểm tín dụng, phân hạng khách
├── components/                   # Các component con chỉ dùng riêng cho Customers
│   ├── CustomersTable.tsx        # Bảng hiển thị danh sách
│   ├── CustomersToolbar.tsx      # Bộ lọc, tìm kiếm, nút thêm mới
│   ├── CustomerDetailDrawer.tsx  # Ngăn kéo xem chi tiết
│   └── CustomerFormModal.tsx     # Popup thêm / sửa khách hàng
└── hooks/                        # Các Custom Hook nghiệp vụ độc lập
    ├── useCustomersData.ts       # Hook gọi API và quản lý state danh sách
    ├── useCustomerSelection.ts   # Hook quản lý chọn nhiều khách hàng
    └── useCustomerFilters.ts     # Hook quản lý từ khóa tìm kiếm & bộ lọc
```

### 1. `src/modules/customers/CustomersView.tsx` (Mẫu)
```tsx
import React from 'react';
import { CustomersToolbar } from './components/CustomersToolbar';
import { CustomersTable } from './components/CustomersTable';
import { CustomerFormModal } from './components/CustomerFormModal';
import { useCustomersData } from './hooks/useCustomersData';
import { useCustomerSelection } from './hooks/useCustomerSelection';

export const CustomersView: React.FC = () => {
  // Lấy dữ liệu và logic từ Custom Hooks chuyên biệt
  const { customers, loading, refreshCustomers } = useCustomersData();
  const { selectedIds, toggleSelect, selectAll, clearSelection } = useCustomerSelection();

  return (
    <div className="flex-1 flex flex-col h-full bg-slate-50 p-6 space-y-4">
      {/* 1. Toolbar */}
      <CustomersToolbar
        totalCount={customers.length}
        selectedCount={selectedIds.size}
        onRefresh={refreshCustomers}
      />

      {/* 2. Table */}
      <CustomersTable
        data={customers}
        loading={loading}
        selectedIds={selectedIds}
        onToggleSelect={toggleSelect}
      />

      {/* 3. Modals */}
      <CustomerFormModal onSuccess={refreshCustomers} />
    </div>
  );
};
```

### 2. `src/types/customers.ts` (Mẫu Định Nghĩa Dữ Liệu)
```ts
export interface CustomerItem {
  id: string;
  code: string;
  name: string;
  phone: string;
  email: string;
  totalOrders: number;
  totalSpent: number;
  status: 'active' | 'inactive' | 'vip';
  createdAt: string;
}
```
*Lưu ý*: Với cấu trúc này, module `customers` hoàn toàn tự đóng gói, không phụ thuộc vào bất kỳ module nào khác trong hệ thống.
