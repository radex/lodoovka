//
//  WindowManager.m
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "WindowManager.h"
#import "Lodoovka.h"
#import "Geometry.h"

void wndmgr_init()
{
    window_stack = window_stack_tip = NULL;
}

window_ref wndmgr_add(window_ref wnd)
{
    window_sref swnd = malloc(sizeof(struct StackedWindow));
    swnd->wnd = wnd;
    swnd->next = NULL;
    
    if(window_stack_tip)
    {
        window_stack_tip->next = swnd;
        window_stack_tip = swnd;
    }
    else
    {
        window_stack = window_stack_tip = swnd;
    }
    
    lodoovka_redraw();
    _wndmgr_log_windows();
    
    return wnd;
}

void wndmgr_order_back(window_ref wnd)
{
    window_sref to_order = _wndmgr_find(wnd);
    
    if(window_stack == to_order) return;
    
    window_sref wnd_before = _wndmgr_find_before(to_order);
    wnd_before->next = to_order->next;
    
    if(window_stack_tip == to_order)
    {
        window_stack_tip = wnd_before;
    }
    
    to_order->next = window_stack;
    window_stack = to_order;
    
    _wndmgr_log_windows();
    lodoovka_redraw();
}

void wndmgr_order_front(window_ref wnd)
{
    window_sref to_order = _wndmgr_find(wnd);
    
    if(window_stack_tip == to_order) return;
    
    if(window_stack == to_order)
    {
        window_stack = to_order->next;
    }
    else
    {
        window_sref wnd_before = _wndmgr_find_before(to_order);
        wnd_before->next = to_order->next;
    }
    
    to_order->next = NULL;
    window_stack_tip->next = to_order;
    window_stack_tip = to_order;
    
    _wndmgr_log_windows();
    lodoovka_redraw();
}

void wndmgr_close(window_ref wnd)
{
    window_sref to_close = _wndmgr_find(wnd);
    
    if(window_stack == to_close)
    {
        window_stack = to_close->next;
    }
    else
    {
        window_sref wnd_before = _wndmgr_find_before(to_close);
        wnd_before->next = to_close->next;
    }
    
    
    window_sref sref = window_stack;
    
    do
    {
        window_stack_tip = sref;
    }
    while(sref && (sref = sref->next));
    
    // todo: free memory
    
    _wndmgr_log_windows();
    lodoovka_redraw();
}

window_sref _wndmgr_find(window_ref wnd)
{
    window_sref sref = window_stack;
    
    do
    {
        if(sref->wnd == wnd) return sref;
    }
    while((sref = sref->next));
    
    return NULL;
}

window_sref _wndmgr_find_before(window_sref wnd)
{
    window_sref wnd_before = window_stack;
    
    do
    {
        if(wnd_before->next == wnd) return wnd_before;
    }
    while((wnd_before = wnd_before->next));
    
    return NULL;
}

void _wndmgr_log_windows()
{
    window_sref sref = window_stack;
    
    if(!window_stack) return;
    
    char *log = "Windows: ";
    
    do
    {
        if(sref->wnd->title)
        {
            char *log2;
            asprintf(&log2, "%s%s, ", log, sref->wnd->title);
            log = log2;
        }
    }
    while((sref = sref->next));
    
    NSLog(@"%s", log);
}

window_ref _wndmgr_keywnd = NULL;

void wndmgr_hangle_event(Event e)
{
    if(e.type == ET_MouseDown)
    {
        if(point_in_rect(e.loc, plusbtnf()))
        {
            plusbtn_clicked();
        }
        else
        {
            window_sref clicked_wnd = _wndmgr_find_clicked(e);
            if(!clicked_wnd) return;
            
            _wndmgr_keywnd = clicked_wnd->wnd;
            
            wndmgr_order_front(_wndmgr_keywnd);
            window_handle_event(_wndmgr_keywnd, e);
        }
    }
    else
    {
        if(_wndmgr_keywnd)
        {
            window_handle_event(_wndmgr_keywnd, e);
        }
        
        if(e.type == ET_MouseUp)
        {
            _wndmgr_keywnd = NULL;
        }
    }
}

window_sref _wndmgr_find_clicked(Event e)
{
    window_sref sref = window_stack;
    window_sref clicked_wnd = NULL;
    
    if(!sref) return NULL;
    
    do
    {
        if(point_in_rect(e.loc, sref->wnd->frame))
        {
            clicked_wnd = sref;
        }
    }
    while((sref = sref->next));
    
    return clicked_wnd;
}