//
//  Geometry.h
//  lodoovka
//
//  Created by Radosław Pietruszewski on 11.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

typedef struct
{
    short x, y;
} l_point;

typedef struct
{
    short x, y, w, h;
} l_rect;

BOOL point_in_rect(l_point point, l_rect rect);

l_rect inset_recta(l_rect rect, short inset);
l_rect inset_rectb(l_rect rect, short topbottom, short leftright);
l_rect inset_rectc(l_rect rect, short top, short right, short bottom, short left);