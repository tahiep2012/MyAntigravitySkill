import React, { useState } from 'react';
import { Package, Plus, Download, Filter } from 'lucide-react';
import {
  PageHeader,
  Card,
  CardContent,
  SearchInput,
  Button,
  Badge,
} from '@/components/ui';

export const StandardPageTemplate: React.FC = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [loading, setLoading] = useState(false);

  return (
    <div className="h-full flex flex-col flex-1 w-full min-h-0 space-y-4 p-4 lg:p-6 overflow-hidden">
      {/* 1. Header chuẩn của trang */}
      <PageHeader
        title="Quản Lý Kho Hàng"
        description="Theo dõi xuất nhập tồn, vị trí vật tư và biến động số lượng thẻ kho"
        badge="V2.0 Chuẩn"
        icon={Package}
        actions={
          <div className="flex items-center gap-2">
            <Button variant="outline" icon={Download} size="md">
              Xuất Excel
            </Button>
            <Button variant="primary" icon={Plus} size="md" onClick={() => {}}>
              Tạo phiếu mới
            </Button>
          </div>
        }
      />

      {/* 2. Khung thẻ Card chứa toàn bộ bảng dữ liệu */}
      <Card variant="default" rounded="3xl" className="flex-1 flex flex-col min-h-0">
        {/* Thanh công cụ tìm kiếm và lọc */}
        <div className="p-4 border-b border-slate-100 flex items-center justify-between gap-4 bg-slate-50/50 shrink-0">
          <div className="flex-1 max-w-md">
            <SearchInput
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              placeholder="Tìm kiếm vật tư, đơn vị, mã kho..."
              shortcutHint="Ctrl+K"
            />
          </div>

          <div className="flex items-center gap-2">
            <Button variant="ghost" size="sm" icon={Filter}>
              Bộ lọc
            </Button>
            <Badge variant="brand" dot={true}>
              1,240 mặt hàng
            </Badge>
          </div>
        </div>

        {/* Nội dung bảng co giãn theo màn hình */}
        <CardContent className="flex-1 overflow-auto p-0">
          <div className="p-6 text-center text-xs text-slate-400">
            [Bảng dữ liệu hoặc danh sách hiển thị tại đây]
          </div>
        </CardContent>
      </Card>
    </div>
  );
};
