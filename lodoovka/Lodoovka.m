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

void lodoovka_main()
{
    lodoovka_redraw();
    wndmgr_init();
}

void lodoovka_redraw()
{
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
    
    draw_plusbtn();
}

void draw_desktop()
{
    setColor(180, 180, 180);
    drawRect(0, 0, 800, 600);
}

l_rect plusbtnf()
{
    l_rect lodoovka_screenf = {0, 0, 800, 600};
    
    return bl_corner(inset_recta(lodoovka_screenf, 15), 32, 32);
}

void draw_plusbtn()
{
    l_rect f = plusbtnf();
    
    setGrey(80);
    drawRectr(f);
    drawRectr(inset_rectc(f, 1, -1, -1, 1));
    setGrey(200);
    drawRectr(inset_recta(f, 1));
}

short window_counter = 0;

void plusbtn_clicked()
{
    short x = arc4random() % (800 - 50);
    short y = arc4random() % (600 - 50);
    short w = arc4random() % (800 - 50) + 50;
    short h = arc4random() % (600 - 50) + 50;
    
    char *title;
    asprintf(&title, "%i", window_counter++);
    
    wndmgr_add(window_create(x, y, w, h, title));
}