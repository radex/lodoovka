//
//  Event.h
//  lodoovka
//
//  Created by Radosław Pietruszewski on 11.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#pragma once

#include "Geometry.h"

enum Event_Type
{
    ET_MouseDown,
    ET_MouseDrag,
    ET_MouseUp
};

typedef struct Event
{
    enum Event_Type type;
    l_point loc;
} Event;

