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

    const int rzr = 4;
    const int rzr_c = 25;
    const int rzr_cb = rzr_c + 1;
    const int ttb = 20;
    
    // border
    
    setColor(80, 80, 80);
    drawRectr(frame);
    
    setColor(200, 200, 200);
    drawRectr(inset_recta(frame, 1));
    
    // resizers

    setColor(80, 80, 80);
    drawRect(x+1,              y+1,                rzr_cb, rzr_cb);
    drawRect(x+w - (rzr_cb+1), y+1,                rzr_cb, rzr_cb);
    drawRect(x+1,              y+h - (rzr_cb+1),   rzr_cb, rzr_cb);
    drawRect(x+w - (rzr_cb+1), y+h - (rzr_cb+1),   rzr_cb, rzr_cb);

    setColor(200, 200, 200);
    drawRect(x+1,            y+1,              rzr_c, rzr_c);
    drawRect(x+w - (rzr_cb), y+1,              rzr_c, rzr_c);
    drawRect(x+1,            y+h - (rzr_cb),   rzr_c, rzr_c);
    drawRect(x+w - (rzr_cb), y+h - (rzr_cb),   rzr_c, rzr_c);
    
    // content border
    
    setColor(80, 80, 80);
    drawRectr(inset_recta(frame, 1+rzr));
    
    // titlebar and close button
    
    setColor(200, 200, 200);
    l_rect ttbf = inset_recta(frame, 1+rzr+1);
    ttbf.h = ttb;
    
    l_rect cbtnf = ttbf;
    cbtnf.w = ttb;
    drawRectr(cbtnf);
    
    ttbf = inset_rectc(ttbf, 0, 0, 0, ttb + 1);
    drawRectr(ttbf);
    
    // content
    
    setColor(230, 230, 230);
    
    l_rect contf = inset_rectc(inset_recta(frame, 1+rzr+1), ttb + 1, 0, 0, 0);
    drawRectr(contf);
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