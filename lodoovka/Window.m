//
//  Window.m
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "Window.h"
#import "Drawing.h"
#import "Lodoovka.h"

window_ref window_create(short x, short y, short w, short h, const char *title)
{
    window_ref wnd = malloc(sizeof(struct Window));
    
    l_rect frame = {x, y, w, h};
    wnd->frame = frame;
    
    wnd->title = malloc(strlen(title));
    strcpy(wnd->title, title);
    
    return wnd;
}

void window_draw(window_ref wnd)
{
    l_rect frame = wnd->frame;
    int x = frame.x;
    int y = frame.y;
    int w = frame.w;
    int h = frame.h;
//
//    const int rzr = 4;
//    const int rzr_c = 20;
//    const int rzr_cb = 21;
//    
    setColor(80, 80, 80);
    drawRect(x, y, w, h);
    
    setColor(230, 230, 230);
    drawRect(x + 1, y + 1, w - 2, h - 2);
//
//    setColor(80, 80, 80);
//    drawRect(x + 1,              y + 1,        rzr_cb, rzr_cb);
//    drawRect(x + w - rzr_cb - 1, y + 1,        rzr_cb, rzr_cb);
//    drawRect(x + 1,              y + h - 22,   rzr_cb, rzr_cb);
//    drawRect(x + w - rzr_cb - 1, y + h - 22,   rzr_cb, rzr_cb);
//    
//    setColor(200, 200, 200);
//    drawRect(x + 1,            y + 1,             20, 20);
//    drawRect(x + w - 21,  y + 1,             20, 20);
//    drawRect(x + 1,            y + h - 21,   20, 20);
//    drawRect(x + w - 21,  y + h - 21,   20, 20);
//    
//    setColor(80, 80, 80);
//    drawRect(x + 5, y + 5, w - 10, h - 10);
//    
//    setColor(200, 200, 200);
//    drawRect(x + 6, y + 6, w - 12, h - 12);
//    
//    setColor(230, 230, 230);
//    drawRect(x + 6, y + 6, w - 12, 20);
//    
//    setColor(80, 80, 80);
//    drawLineH(x + 6, y + 26, w - 12);
//    drawLineV(x + 6 + 20, y + 6, 20);
//    drawLineV(x + 6 + 40, y + 6, 20);
//    drawLineV(x + 6 + 60, y + 6, 20);
}



void window_handle_event(window_ref wnd, Event e)
{
//    NSLog(@"%s: %i @ %ix%i", wnd->title, e.type, e.loc.x, e.loc.y);
    
    if(e.type == ET_MouseDown)
    {
        wnd->_drag_loc = e.loc;
    }
    else if(e.type == ET_MouseDrag)
    {
        short dx = e.loc.x - wnd->_drag_loc.x;
        short dy = e.loc.y - wnd->_drag_loc.y;
        
        wnd->frame.x += dx;
        wnd->frame.y += dy;
        
        wnd->_drag_loc = e.loc;
        
        lodoovka_redraw();
    }
}