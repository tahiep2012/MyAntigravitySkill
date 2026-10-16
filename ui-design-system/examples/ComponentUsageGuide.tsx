import React, { useState } from 'react';
import { Plus, Trash2, CheckCircle2, Search, Settings } from 'lucide-react';
import { Button, Badge, Input, SearchInput, Modal } from '@/components/ui';

export const ComponentUsageGuide: React.FC = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [searchValue, setSearchValue] = useState('');

  return (
    <div className="p-8 space-y-8 max-w-4xl mx-auto bg-slate-50 min-h-screen">
      <div>
        <h2 className="text-xl font-bold text-slate-900">Hướng Dẫn Sử Dụng Bộ Component UI Chuẩn</h2>
        <p className="text-xs text-slate-500 mt-1">
          Tham khảo các cách gọi và biến thể của từng component trong hệ thống.
        </p>
      </div>

      {/* 1. BUTTONS */}
      <div className="p-5 bg-white rounded-3xl border border-slate-200/80 shadow-xs space-y-3">
        <h3 className="text-xs font-bold text-slate-700 uppercase tracking-wider">1. Nút Bấm (Buttons)</h3>
        <div className="flex flex-wrap items-center gap-2">
          <Button variant="primary" icon={Plus}>Nút Chính (Primary)</Button>
          <Button variant="secondary">Nút Thứ Cấp (Secondary)</Button>
          <Button variant="outline">Nút Viền (Outline)</Button>
          <Button variant="ghost">Nút Trong Suốt (Ghost)</Button>
          <Button variant="danger" icon={Trash2}>Nút Xóa (Danger)</Button>
          <Button variant="success" icon={CheckCircle2}>Nút Duyệt (Success)</Button>
          <Button variant="primary" loading={true}>Đang xử lý</Button>
          <Button variant="secondary" size="icon" icon={Settings} />
        </div>
      </div>

      {/* 2. BADGES */}
      <div className="p-5 bg-white rounded-3xl border border-slate-200/80 shadow-xs space-y-3">
        <h3 className="text-xs font-bold text-slate-700 uppercase tracking-wider">2. Nhãn Trạng Thái (Badges)</h3>
        <div className="flex flex-wrap items-center gap-2">
          <Badge variant="brand" dot={true}>Thương hiệu (Brand)</Badge>
          <Badge variant="success" dot={true}>Đã thanh toán (Success)</Badge>
          <Badge variant="warning" dot={true}>Chờ phê duyệt (Warning)</Badge>
          <Badge variant="danger" dot={true}>Đã hủy bỏ (Danger)</Badge>
          <Badge variant="info">Phân hệ Kho (Info)</Badge>
          <Badge variant="default">Mặc định (Default)</Badge>
        </div>
      </div>

      {/* 3. INPUTS */}
      <div className="p-5 bg-white rounded-3xl border border-slate-200/80 shadow-xs space-y-3">
        <h3 className="text-xs font-bold text-slate-700 uppercase tracking-wider">3. Ô Nhập Liệu & Tìm Kiếm</h3>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <SearchInput
            value={searchValue}
            onChange={(e) => setSearchValue(e.target.value)}
            placeholder="Tìm kiếm đơn hàng..."
            shortcutHint="Ctrl+K"
          />
          <Input
            icon={Search}
            placeholder="Ô nhập dữ liệu thông thường..."
          />
        </div>
      </div>

      {/* 4. MODAL DEMO */}
      <div className="p-5 bg-white rounded-3xl border border-slate-200/80 shadow-xs space-y-3">
        <h3 className="text-xs font-bold text-slate-700 uppercase tracking-wider">4. Cửa Sổ Hộp Thoại (Modal)</h3>
        <Button variant="primary" onClick={() => setIsModalOpen(true)}>
          Mở Cửa Sổ Hộp Thoại Mẫu
        </Button>

        <Modal
          isOpen={isModalOpen}
          onClose={() => setIsModalOpen(false)}
          title="Cửa Sổ Hộp Thoại Tiêu Chuẩn"
          description="Nền mờ nhẹ, bo góc lớn 24px, tự đóng khi ấn Esc"
          maxWidth="md"
          footer={
            <>
              <Button variant="secondary" onClick={() => setIsModalOpen(false)}>
                Hủy bỏ
              </Button>
              <Button variant="primary" onClick={() => setIsModalOpen(false)}>
                Xác nhận lưu
              </Button>
            </>
          }
        >
          <p className="text-xs text-slate-600 leading-relaxed">
            Nội dung form hoặc danh sách tùy chỉnh hiển thị tại đây một cách nhất quán với toàn bộ phần mềm.
          </p>
        </Modal>
      </div>
    </div>
  );
};
