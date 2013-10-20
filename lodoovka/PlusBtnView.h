#pragma once

#include "View.h"

view_ref plusbtn_create();
void plusbtn_painter(view_ref view, l_rect frame);
void plusbtn_mouse_down(view_ref view, l_event e);
void plusbtn_mouse_up(view_ref view, l_event e);