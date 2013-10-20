#pragma once

#include "Geometry.h"
#include "Event.h"

struct l_view
{
    l_rect frame;
    
    void (*painter)(struct l_view*, l_rect);
    void (*mouse_down)(struct l_view*, l_event);
    void (*mouse_drag)(struct l_view*, l_event);
    void (*mouse_up)(struct l_view*, l_event);
    
    void *userinfo;
};

typedef struct l_view* view_ref;

view_ref view_create(short x, short y, short w, short h);
view_ref view_createf(l_rect frame);

void view_draw(view_ref view, l_rect superframe);