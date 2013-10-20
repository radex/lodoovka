#include <stdlib.h>

#include "TestView.h"
#include "Drawing.h"

view_ref testview_create(l_rect frame)
{
    frame.x = 0;
    frame.y = 0;
    
    view_ref view = view_createf(frame);
    view->painter = testview_painter;
    view->mouse_down = testview_mouseup;
    
    testview_randomize(view);
    
    return view;
}

void testview_painter(view_ref view, l_rect frame)
{
    struct testview_color *color = view->userinfo;
    setColor(color->r, color->b, color->g);
    drawRectr(frame);
}

void testview_randomize(view_ref view)
{
    struct testview_color *color;
    
    if(view->userinfo)
    {
        color = view->userinfo;
    }
    else
    {
        color = malloc(sizeof(struct testview_color));
        view->userinfo = color;
    }
    
    color->r = rand() % 255;
    color->g = rand() % 255;
    color->b = rand() % 255;
}

void testview_mouseup(view_ref view, l_event e)
{
    testview_randomize(view);
}