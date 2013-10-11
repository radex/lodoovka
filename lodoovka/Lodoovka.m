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
    
    wndmgr_add(window_create(50, 70,   300, 200, "1"));
    wndmgr_add(window_create(100, 100, 400, 300, "2"));
    wndmgr_add(window_create(300, 300, 400, 300, "3"));
    wndmgr_add(window_create(200, 450, 200, 100, "4"));
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