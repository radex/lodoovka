//
//  Lodoovka.m
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "Lodoovka.h"
#import "Drawing.h"
#import "Window.h"
#import "WindowManager.h"

void draw_desktop()
{
    setColor(180, 180, 180);
    drawRect(0, 0, 800, 600);
}

//window_ref global_windows[100];

void lodoovka_main()
{
    lodoovka_redraw();
    wndmgr_init();
    
    window_sref wnd1 = wndmgr_add(window_create(50, 70, 300, 200));
    window_sref wnd2 = wndmgr_add(window_create(100, 100, 400, 300));
    window_sref wnd3 = wndmgr_add(window_create(300, 300, 400, 300));
    window_sref wnd4 = wndmgr_add(window_create(200, 450, 200, 100));
    
    [NSTimer in:1 do:^{
        wndmgr_order_back(wnd2);
    }];
    
    [NSTimer in:2 do:^{
        wndmgr_order_back(wnd4);
    }];
    
    [NSTimer in:3 do:^{
        wndmgr_order_back(wnd3);
    }];
}

void lodoovka_redraw()
{
    draw_desktop();
    
    window_sref sref = window_stack;
    
    if(!window_stack) return;
    
    do
    {
        window_draw(sref->wnd);
    }
    while((sref = sref->next));
}