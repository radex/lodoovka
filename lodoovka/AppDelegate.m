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
    lodoovka_main();
}

+ (Screen *)globalScreen
{
    AppDelegate *delegate = [NSApp delegate];
    return delegate.screen;
}

@end
