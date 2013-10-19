#include "Window.h"
#include "Event.h"

struct StackedWindow {
    window_ref wnd;
    struct StackedWindow* next;
};

typedef struct StackedWindow* window_sref;

window_sref window_stack;
window_sref window_stack_tip;

void wndmgr_init();
window_ref wndmgr_add(window_ref wnd);

void wndmgr_order_back(window_ref wnd);
void wndmgr_order_front(window_ref wnd);

void wndmgr_close(window_ref wnd);

window_sref _wndmgr_find(window_ref wnd);
window_sref _wndmgr_find_before(window_sref wnd);
void _wndmgr_log_windows();

void wndmgr_hangle_event(Event e);
window_sref _wndmgr_find_clicked(Event e);