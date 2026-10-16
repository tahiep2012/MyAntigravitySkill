/**
 * Mẫu Triển Khai Giao Tiếp Giữa Các Module Độc Lập Bằng Event Bus (Custom Events)
 * Đảm bảo 100% không có sự phụ thuộc lẫn nhau (Loose Coupling).
 */

// 1. Định nghĩa các tên sự kiện chuẩn hoá toàn hệ thống
export const APP_EVENTS = {
  SHORTCUTS_UPDATED: 'app_shortcuts_updated',
  COLUMNS_UPDATED: 'app_columns_updated',
  DISPLAY_SETTINGS_UPDATED: 'app_display_settings_updated',
  ORDER_STATUS_CHANGED: 'app_order_status_changed',
} as const;

// 2. Module A (Phát sự kiện - Event Publisher)
// Ví dụ: Trong SettingsView khi người dùng đổi phím tắt hoặc giao diện:
export function emitShortcutsUpdated(newShortcuts: any[]): void {
  try {
    const event = new CustomEvent(APP_EVENTS.SHORTCUTS_UPDATED, {
      detail: newShortcuts,
    });
    window.dispatchEvent(event);
  } catch (error) {
    console.error('Failed to emit shortcuts event:', error);
  }
}

// 3. Module B (Lắng nghe sự kiện - Event Subscriber)
// Ví dụ: Trong OrdersView hoặc AppView muốn cập nhật lại bảng phím tắt mới:
/*
import { useEffect, useState } from 'react';
import { APP_EVENTS } from './event_bus_communication';

export function useShortcutsSync() {
  const [shortcuts, setShortcuts] = useState(() => getInitialShortcuts());

  useEffect(() => {
    const handleUpdate = (e: Event) => {
      const customEvent = e as CustomEvent;
      if (customEvent.detail) {
        setShortcuts(customEvent.detail);
      }
    };

    window.addEventListener(APP_EVENTS.SHORTCUTS_UPDATED, handleUpdate);
    return () => {
      window.removeEventListener(APP_EVENTS.SHORTCUTS_UPDATED, handleUpdate);
    };
  }, []);

  return shortcuts;
}
*/
