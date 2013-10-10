//
//  AppDelegate.m
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "AppDelegate.h"
#import "Drawing.h"
#import "Lodoovka.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
//    setColor(220, 220, 220);
//    drawRect(0, 0, 800, 600);
//
//    [NSTimer in:0.5 do:^
//    {
//        setColor(0, 0, 0);
//        drawRect(100, 100, 600, 400);
//        
//        setColor(255, 255, 255);
//        drawLineH(100, 120, 600);
//        drawLineV(120, 100, 20);
//        drawLineV(140, 100, 20);
//        drawLineV(160, 100, 20);
//    }];
    
    [NSTimer in:1 do:^{ lodoovka_main(); }];
}

+ (Screen *)globalScreen
{
    AppDelegate *delegate = [NSApp delegate];
    return delegate.screen;
}

@end
