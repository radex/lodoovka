#include <stdlib.h>
#include <time.h>
#include <math.h>

#include "Logging.h"
#include "Lodoovka.h"
#include "Drawing.h"
#include "Window.h"
#include "WindowManager.h"

void lodoovka_main()
{
    srand((unsigned int) time(0));
    
    lodoovka_redraw();
    wndmgr_init();
}

void lodoovka_redraw()
{
    draw_desktop();
    
    window_sref sref = window_stack;
    
    if(window_stack)
    {
        do
        {
            window_draw(sref->wnd);
        }
        while((sref = sref->next));
    }
    
    draw_plusbtn();
}

void draw_desktop()
{
    setColor(180, 180, 180);
    drawRect(0, 0, 800, 600);
}

l_rect plusbtnf()
{
    l_rect lodoovka_screenf = {0, 0, 800, 600};
    
    return bl_corner(inset_recta(lodoovka_screenf, 15), 32, 32);
}

void draw_plusbtn()
{
    l_rect f = plusbtnf();
    
    setGrey(80);
    drawRectr(f);
    drawRectr(inset_rectc(f, 1, -1, -1, 1));
    setGrey(200);
    drawRectr(inset_recta(f, 1));
}

short window_counter = 0;

void plusbtn_clicked()
{
    short w = (rand() % (700 - 100)) + 100;
    short minh = w * 2/3;
    short maxh = w * 3/2;
    short h = (rand() % (maxh - minh)) + minh;
    if(h > 500) h = 500;
    short x = (rand() % (800 - w));
    short y = (rand() % (600 - h));
        
    char *title;
    asprintf(&title, "%i", window_counter++);
    
    wndmgr_add(window_create(x, y, w, h, title));
    
    lodoovka_logf("Created %s", title);
}