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
#import "WindowManager.h"

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

#define window_resizer 5
#define window_cresizer 26
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

#define WEM_color(mode) if(wnd->eventmode == mode){ setGrey(255); } else { setGrey(200); }

void window_draw(window_ref wnd)
{
    l_rect frame = wnd->frame;
    
    // border
    
    setGrey(80);
    drawRectr(frame);
    
    // resizers
    
//    setGrey(200);
    
    WEM_color(WEM_Resize_tl) drawRectr(window_tl_resizerf(frame));
    WEM_color(WEM_Resize_tr) drawRectr(window_tr_resizerf(frame));
    WEM_color(WEM_Resize_br) drawRectr(window_br_resizerf(frame));
    WEM_color(WEM_Resize_bl) drawRectr(window_bl_resizerf(frame));
    
    WEM_color(WEM_Resize_t) drawRectr(window_t_resizerf(frame));
    WEM_color(WEM_Resize_r) drawRectr(window_r_resizerf(frame));
    WEM_color(WEM_Resize_b) drawRectr(window_b_resizerf(frame));
    WEM_color(WEM_Resize_l) drawRectr(window_l_resizerf(frame));
    
    // content border
    
    setGrey(80);
    drawRectr(inset_recta(frame, 1 + window_resizer));
    
    // titlebar and close button
    
//    setGrey(200);
    
    WEM_color(WEM_Close) drawRectr(window_close_buttonf(frame));
    WEM_color(WEM_Move)  drawRectr(window_titlebarf(frame));
    
    // content
    
    setGrey(230);
    drawRectr(window_contentf(frame));
}



void window_handle_event(window_ref wnd, Event e)
{
//    NSLog(@"%s: %i @ %ix%i", wnd->title, e.type, e.loc.x, e.loc.y);
    
    if(e.type == ET_MouseDown)
    {
        if(point_in_rect(e.loc, inset_recta(wnd->frame, 1+window_resizer)))
        {
            if(point_in_rect(e.loc, window_titlebarf(wnd->frame)))
            {
                wnd->eventmode = WEM_Move;
                wnd->_drag_loc = e.loc;
            }
            else if(point_in_rect(e.loc, window_close_buttonf(wnd->frame)))
            {
                wnd->eventmode = WEM_Close;
            }
        }
        else
        {
            if(point_in_rect(e.loc, window_tl_resizerf(wnd->frame)))        wnd->eventmode = WEM_Resize_tl;
            else if(point_in_rect(e.loc, window_tr_resizerf(wnd->frame)))   wnd->eventmode = WEM_Resize_tr;
            else if(point_in_rect(e.loc, window_br_resizerf(wnd->frame)))   wnd->eventmode = WEM_Resize_br;
            else if(point_in_rect(e.loc, window_bl_resizerf(wnd->frame)))   wnd->eventmode = WEM_Resize_bl;
            else if(point_in_rect(e.loc, window_t_resizerf(wnd->frame)))    wnd->eventmode = WEM_Resize_t;
            else if(point_in_rect(e.loc, window_r_resizerf(wnd->frame)))    wnd->eventmode = WEM_Resize_r;
            else if(point_in_rect(e.loc, window_b_resizerf(wnd->frame)))    wnd->eventmode = WEM_Resize_b;
            else if(point_in_rect(e.loc, window_l_resizerf(wnd->frame)))    wnd->eventmode = WEM_Resize_l;
            
            wnd->_drag_loc = e.loc;
        }
        
        lodoovka_redraw();
    }
    else if(e.type == ET_MouseDrag)
    {
        short dx = e.loc.x - wnd->_drag_loc.x;
        short dy = e.loc.y - wnd->_drag_loc.y;
        
        if(wnd->eventmode == WEM_Move)
        {
            wnd->frame.x += dx;
            wnd->frame.y += dy;
        }
        
        if(wnd->eventmode == WEM_Resize_t || wnd->eventmode == WEM_Resize_tl || wnd->eventmode == WEM_Resize_tr)
        {
            wnd->frame.h -= dy;
            wnd->frame.y += dy;
        }
        
        if(wnd->eventmode == WEM_Resize_r || wnd->eventmode == WEM_Resize_tr || wnd->eventmode == WEM_Resize_br)
        {
            wnd->frame.w += dx;
        }
        
        if(wnd->eventmode == WEM_Resize_b || wnd->eventmode == WEM_Resize_bl || wnd->eventmode == WEM_Resize_br)
        {
            wnd->frame.h += dy;
        }
        
        if(wnd->eventmode == WEM_Resize_l || wnd->eventmode == WEM_Resize_tl || wnd->eventmode == WEM_Resize_bl)
        {
            wnd->frame.w -= dx;
            wnd->frame.x += dx;
        }
        
        wnd->_drag_loc = e.loc;
        
        lodoovka_redraw();
    }
    else if(e.type == ET_MouseUp)
    {
        if(wnd->eventmode == WEM_Close && point_in_rect(e.loc, window_close_buttonf(wnd->frame)))
        {
            wndmgr_close(wnd);
            return;
        }
        
        wnd->eventmode = WEM_None;
        
        lodoovka_redraw();
    }
}