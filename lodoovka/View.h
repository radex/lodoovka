#pragma once

#include "Geometry.h"
#include "Event.h"

struct l_view
{
    l_rect frame;
    
    void (*painter)(l_rect);
    void (*mouse_down)(l_event);
    void (*mouse_drag)(l_event);
    void (*mouse_up)(l_event);
};

typedef struct l_view* view_ref;

view_ref view_create(short x, short y, short w, short h);
view_ref view_createf(l_rect frame);