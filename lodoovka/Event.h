//
//  Event.h
//  lodoovka
//
//  Created by Radosław Pietruszewski on 11.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

enum Event_Type
{
    ET_MouseDown,
    ET_MouseDrag,
    ET_MouseUp
};

typedef struct Event
{
    enum Event_Type type;
    short x, y;
} Event;