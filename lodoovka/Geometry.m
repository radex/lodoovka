//
//  Geometry.m
//  lodoovka
//
//  Created by Radosław Pietruszewski on 11.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "Geometry.h"

BOOL point_in_rect(l_point point, l_rect rect)
{
    if(point.x >= rect.x &&
       point.x <  rect.x + rect.w &&
       point.y >= rect.y &&
       point.y <  rect.y + rect.h)
    {
        return YES;
    }
    
    return NO;
}

l_rect inset_recta(l_rect rect, short inset)
{
    return inset_rectc(rect, inset, inset, inset, inset);
}

l_rect inset_rectb(l_rect rect, short topbottom, short leftright)
{
    return inset_rectc(rect, topbottom, leftright, topbottom, leftright);
}

l_rect inset_rectc(l_rect rect, short top, short right, short bottom, short left)
{
    rect.x += left;
    rect.y += top;
    rect.w -= (left + right);
    rect.h -= (top + bottom);
    
    return rect;
}