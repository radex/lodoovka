//
//  WindowManager.h
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "Window.h"

struct StackedWindow {
    window_ref wnd;
    struct StackedWindow* next;
};

typedef struct StackedWindow* window_sref;

window_sref window_stack;
window_sref window_stack_tip;

void wndmgr_init();
window_sref wndmgr_add(window_ref wnd);

void wndmgr_order_back(window_sref wnd);
void wndmgr_order_front(window_sref wnd);

void wndmgr_close(window_sref wnd);

window_sref _wndmgr_find_before(window_sref wnd);