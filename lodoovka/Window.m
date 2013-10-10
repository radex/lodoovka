//
//  Window.m
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "Window.h"
#import "Drawing.h"

window_ref window_create(short x, short y, short w, short h)
{
    window_ref wnd = malloc(sizeof(struct Window));
    wnd->x = x;
    wnd->y = y;
    wnd->w = w;
    wnd->h = h;
    
    return wnd;
}

void window_draw(window_ref wnd)
{
    int x = wnd->x;
    int y = wnd->y;
    int w = wnd->w;
    int h = wnd->h;
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