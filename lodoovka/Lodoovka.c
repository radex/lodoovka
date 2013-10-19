#include <stdlib.h>
#include <time.h>

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
    short x = rand() % (800 - 50);
    short y = rand() % (600 - 50);
    short w = rand() % (800 - 50) + 50;
    short h = rand() % (600 - 50) + 50;
    
    char *title;
    asprintf(&title, "%i", window_counter++);
    
    wndmgr_add(window_create(x, y, w, h, title));
    
    char *log;
    asprintf(&log, "Created %s", title);
    lodoovka_log(log);
    free(log);
}