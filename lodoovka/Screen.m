//
//  Screen.m
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "Screen.h"

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

@end
