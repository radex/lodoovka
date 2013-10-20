#pragma once

#include "Geometry.h"
#include "Event.h"
#include "View.h"

enum Window_eventmode
{
    WEM_None,
    WEM_Move,
    WEM_Close,
    WEM_Resize_t,
    WEM_Resize_b,
    WEM_Resize_r,
    WEM_Resize_l,
    WEM_Resize_tl,
    WEM_Resize_tr,
    WEM_Resize_br,
    WEM_Resize_bl,
    WEM_Content
};

struct l_window {
    l_rect frame;
    char *title;
    
    view_ref content_view;
    
    l_point _drag_loc;
    enum Window_eventmode eventmode;
};

typedef struct l_window* window_ref;

window_ref window_create(short x, short y, short w, short h, const char *title);
void window_draw(window_ref wnd);

void window_handle_event(window_ref wnd, Event e);