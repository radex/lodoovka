//
//  WindowManager.m
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "WindowManager.h"
#import "Lodoovka.h"

void wndmgr_init()
{
    window_stack = window_stack_tip = NULL;
}

window_sref wndmgr_add(window_ref wnd)
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
    
    return swnd;
}

void wndmgr_order_back(window_sref to_order)
{
    if(window_stack == to_order) return;
    
    window_sref wnd_before = _wndmgr_find_before(to_order);
    wnd_before->next = to_order->next;
    
    if(window_stack_tip == to_order)
    {
        window_stack_tip = wnd_before;
    }
    
    to_order->next = window_stack;
    window_stack = to_order;
    
    
    lodoovka_redraw();
}

void wndmgr_order_front(window_sref to_order)
{
    
}

void wndmgr_close(window_sref wnd)
{
    
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