#include "Drawing.h"
#include "Logging.h"
#import "Screen.h"
#import "AppDelegate.h"

#define fail_if_not_drawing if(!drawing) NSLog(@"Shouldn't be drawing");

NSColor *currentColor;

BOOL drawing;

void startDrawing()
{
    drawing = YES;
    
    [[AppDelegate globalScreen].contents lockFocus];
}

void setColor(unsigned char r, unsigned char g, unsigned char b)
{
    fail_if_not_drawing
    currentColor = RGB(r,g,b);
    
}

void setGrey(unsigned char g)
{
    fail_if_not_drawing
    currentColor = RGB(g,g,g);
}

void drawRect(short x, short y, short w, short h)
{
    fail_if_not_drawing
    [currentColor setFill];
    NSRectFill(NSMakeRect(x, y, w, h));
}

void drawRectr(l_rect rect)
{
    fail_if_not_drawing
    drawRect(rect.x, rect.y, rect.w, rect.h);
}

void drawLineH(short x, short y, short l)
{
    fail_if_not_drawing
    drawRect(x, y, l, 1);
}

void drawLineV(short x, short y, short l)
{
    fail_if_not_drawing
    drawRect(x, y, 1, l);
}

void finishDrawing()
{
    [[AppDelegate globalScreen].contents unlockFocus];
    [[AppDelegate globalScreen] setNeedsDisplay:YES];
}

void lodoovka_log(const char *log)
{
    NSLog(@"%s", log);
}