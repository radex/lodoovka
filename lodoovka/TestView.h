#pragma once

#include "View.h"

struct testview_color{
    char r, g, b;
};

view_ref testview_create(l_rect superframe);
void testview_painter(view_ref view, l_rect frame);
void testview_randomize(view_ref view);
void testview_mouseup(view_ref view, l_event e);