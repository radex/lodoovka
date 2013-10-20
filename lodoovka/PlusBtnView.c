#include "PlusBtnView.h"

#include "Drawing.h"
#include "Lodoovka.h"

view_ref plusbtn_create()
{
    l_rect screen = {0, 0, 800, 600};
    l_rect frame = bl_corner(inset_recta(screen, 15), 32, 32);
    
    view_ref plusbtn = view_createf(frame);
    plusbtn->painter = plusbtn_painter;
    plusbtn->mouse_down = plusbtn_mouse_down;
    
    return plusbtn;
}

void plusbtn_painter(view_ref view, l_rect f)
{
    setGrey(80);
    drawRectr(f);
    drawRectr(inset_rectc(f, 1, -1, -1, 1));
    setGrey(200);
    drawRectr(inset_recta(f, 1));
}

void plusbtn_mouse_down(view_ref view, l_event e)
{
    lodoovka_add_window();
}

void plusbtn_mouse_up(view_ref view, l_event e)
{
}