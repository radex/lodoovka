//
//  Window.h
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "Geometry.h"
#import "Event.h"

struct Window {
    l_rect frame;
    char *title;
    
    l_point _drag_loc;
};

typedef struct Window* window_ref;

window_ref window_create(short x, short y, short w, short h, const char *title);
void window_draw(window_ref wnd);

void window_handle_event(window_ref wnd, Event e);