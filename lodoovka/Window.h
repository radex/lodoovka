//
//  Window.h
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

struct Window {
    short x, y, w, h;
};

typedef struct Window* window_ref;

window_ref window_create(short x, short y, short w, short h);
void window_draw(window_ref wnd);