#include <stdlib.h>

#include "View.h"

view_ref view_create(short x, short y, short w, short h)
{
    l_rect frame = {x, y, w, h};
    return view_createf(frame);
}

view_ref view_createf(l_rect frame)
{
    view_ref v = malloc(sizeof(struct l_view));
    
    v->frame = frame;
    v->painter = NULL;
    v->mouse_down = v->mouse_drag = v->mouse_up = NULL;
    v->userinfo = NULL;
    
    return v;
}

void view_draw(view_ref view, l_rect superframe)
{
    l_rect f = view->frame;
    f.x += superframe.x;
    f.y += superframe.y;
    if(f.w > superframe.w) f.w = superframe.w;
    if(f.h > superframe.h) f.h = superframe.h;
    
    view->painter(view, f);
}