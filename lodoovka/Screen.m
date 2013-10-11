//
//  Screen.m
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "Screen.h"
#import "Event.h"
#import "WindowManager.h"

@implementation Screen

- (void)awakeFromNib
{
    _contents = [NSImage imageSized:self.bounds.size];
}

- (BOOL)isFlipped
{
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSLog(@"drawin'");
    [_contents drawInRect:self.bounds fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
}

- (void)mouseDown:(NSEvent *)theEvent
{
    [self dispatchMouseEvent:theEvent];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    [self dispatchMouseEvent:theEvent];
}

- (void)mouseUp:(NSEvent *)theEvent
{
    [self dispatchMouseEvent:theEvent];
}

- (void) dispatchMouseEvent:(NSEvent*)ev
{
    Event e;
    switch(ev.type)
    {
        case NSLeftMouseDown:       e.type = ET_MouseDown; break;
        case NSLeftMouseDragged:    e.type = ET_MouseDrag; break;
        case NSLeftMouseUp:         e.type = ET_MouseUp;   break;
    }
    
    NSPoint location = [self convertPoint:ev.locationInWindow fromView:nil];
    l_point loc = { location.x, location.y };
    
    short max_x = self.bounds.size.width;
    short max_y = self.bounds.size.height;
    
    if(loc.x > max_x) loc.x = max_x;
    if(loc.x < 0)     loc.x = 0;
    
    if(loc.y > max_y) loc.y = max_y;
    if(loc.y < 0)     loc.y = 0;
    
    e.loc = loc;
    
    wndmgr_hangle_event(e);
}

@end
