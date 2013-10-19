#include "Drawing.h"
#include "Logging.h"
#import "Screen.h"
#import "AppDelegate.h"

NSColor *currentColor;

void setColor(unsigned char r, unsigned char g, unsigned char b)
{
    currentColor = RGB(r,g,b);
}

void setGrey(unsigned char g)
{
    currentColor = RGB(g,g,g);
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

void drawRectr(l_rect rect)
{
    drawRect(rect.x, rect.y, rect.w, rect.h);
}

void drawLineH(short x, short y, short l)
{
    drawRect(x, y, l, 1);
}

void drawLineV(short x, short y, short l)
{
    drawRect(x, y, 1, l);
}

void lodoovka_log(const char *log)
{
    NSLog(@"%s", log);
}