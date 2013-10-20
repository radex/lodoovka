#include <stdlib.h>
#include <time.h>
#include <math.h>

#include "Logging.h"
#include "Lodoovka.h"
#include "Drawing.h"
#include "Window.h"
#include "WindowManager.h"

view_ref plusbtn;

void lodoovka_main()
{
    srand((unsigned int) time(0));
    
    lodoovka_redraw();
    wndmgr_init();
}

void lodoovka_redraw()
{
    startDrawing();
    
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
    
    if(!plusbtn) plusbtn = plusbtn_create();
    plusbtn->painter(plusbtn->frame);
    
    finishDrawing();
}

void draw_desktop()
{
    setColor(180, 180, 180);
    drawRect(0, 0, 800, 600);
}

short window_counter = 0;

void lodoovka_add_window()
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