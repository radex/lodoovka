//
//  Drawing.c
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "Drawing.h"
#import "Screen.h"
#import "AppDelegate.h"

NSColor *currentColor;

void setColor(unsigned char r, unsigned char g, unsigned char b)
{
    currentColor = RGB(r,g,b);
}

void _drawOnScreen(void(^drawing)())
{
    [[AppDelegate globalScreen].contents drawing:^(NSRect frame){
        drawing();
    }];
    [[AppDelegate globalScreen] setNeedsDisplay:YES];
}

void drawRect(short x, short y, short w, short h)
{
    _drawOnScreen(^{ 
        [currentColor setFill];
        NSRectFill(NSMakeRect(x, y, w, h));
    });
}

void drawLineH(short x, short y, short l)
{
    drawRect(x, y, l, 1);
}

void drawLineV(short x, short y, short l)
{
    drawRect(x, y, 1, l);
}