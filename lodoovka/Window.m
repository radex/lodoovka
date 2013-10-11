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
    
    wnd->eventmode = WEM_None;
    
    return wnd;
}

#define window_resizer 4
#define window_cresizer 25
#define window_titlebar_h 20

#define window_tl_resizerf(frame) tl_corner(inset_recta(frame, 1), window_cresizer, window_cresizer)
#define window_tr_resizerf(frame) tr_corner(inset_recta(frame, 1), window_cresizer, window_cresizer)
#define window_br_resizerf(frame) br_corner(inset_recta(frame, 1), window_cresizer, window_cresizer)
#define window_bl_resizerf(frame) bl_corner(inset_recta(frame, 1), window_cresizer, window_cresizer)

#define _window_tb_resizers(frame) inset_rectb(inset_recta(frame, 1), 0, window_cresizer + 1)
#define _window_lr_resizers(frame) inset_rectb(inset_recta(frame, 1), window_cresizer + 1, 0)

#define window_t_resizerf(frame)  inset_rectc(_window_tb_resizers(frame), 0, 0, window_resizer, 0)
#define window_r_resizerf(frame)  inset_rectc(_window_lr_resizers(frame), 0, 0, 0, window_resizer)
#define window_b_resizerf(frame)  inset_rectc(_window_tb_resizers(frame), window_resizer, 0, 0, 0)
#define window_l_resizerf(frame)  inset_rectc(_window_lr_resizers(frame), 0, window_resizer, 0, 0)

#define _window_titlebar_area(frame) t_edge(inset_recta(frame, 1+window_resizer+1), window_titlebar_h)
#define window_close_buttonf(frame) l_edge(_window_titlebar_area(frame), window_titlebar_h)
#define window_titlebarf(frame) inset_rectc(_window_titlebar_area(frame), 0, 0, 0, window_titlebar_h + 1)

#define window_contentf(frame) inset_rectc(inset_recta(frame, 1+window_resizer+1), window_titlebar_h + 1, 0, 0, 0)

#define WEM_color(mode, normal, highlighted) if(wnd->eventmode == mode){ setGrey(highlighted); } else { setGrey(normal); }

void window_draw(window_ref wnd)
{
    l_rect frame = wnd->frame;
    
    // border
    
    setGrey(80);
    drawRectr(frame);
    
    // resizers
    
    setGrey(200);
    drawRectr(window_tl_resizerf(frame));
    drawRectr(window_tr_resizerf(frame));
    drawRectr(window_br_resizerf(frame));
    drawRectr(window_bl_resizerf(frame));
    
    drawRectr(window_t_resizerf(frame));
    drawRectr(window_r_resizerf(frame));
    drawRectr(window_b_resizerf(frame));
    drawRectr(window_l_resizerf(frame));
    
    // content border
    
    setGrey(80);
    drawRectr(inset_recta(frame, 1 + window_resizer));
    
    // titlebar and close button
    
    setGrey(200);
    
    drawRectr(window_close_buttonf(frame));
    WEM_color(WEM_Move, 200, 255) drawRectr(window_titlebarf(frame));
    
    // content
    
    setGrey(230);
    drawRectr(window_contentf(frame));
}



void window_handle_event(window_ref wnd, Event e)
{
//    NSLog(@"%s: %i @ %ix%i", wnd->title, e.type, e.loc.x, e.loc.y);
    
    if(e.type == ET_MouseDown)
    {
        if(point_in_rect(e.loc, window_titlebarf(wnd->frame)))
        {
            wnd->eventmode = WEM_Move;
            wnd->_drag_loc = e.loc;
        }
        
        lodoovka_redraw();
    }
    else if(e.type == ET_MouseDrag)
    {
        if(wnd->eventmode == WEM_Move)
        {
            short dx = e.loc.x - wnd->_drag_loc.x;
            short dy = e.loc.y - wnd->_drag_loc.y;
            
            wnd->frame.x += dx;
            wnd->frame.y += dy;
            
            wnd->_drag_loc = e.loc;
            
            lodoovka_redraw();
        }
    }
    else if(e.type == ET_MouseUp)
    {
        wnd->eventmode = WEM_None;
        
        lodoovka_redraw();
    }
}