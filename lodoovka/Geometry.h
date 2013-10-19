#pragma once

typedef struct
{
    short x, y;
} l_point;

typedef struct
{
    short x, y, w, h;
} l_rect;

char point_in_rect(l_point point, l_rect rect);

l_rect inset_recta(l_rect rect, short inset);
l_rect inset_rectb(l_rect rect, short topbottom, short leftright);
l_rect inset_rectc(l_rect rect, short top, short right, short bottom, short left);

l_rect tl_corner(l_rect rect, short w, short h);
l_rect tr_corner(l_rect rect, short w, short h);
l_rect br_corner(l_rect rect, short w, short h);
l_rect bl_corner(l_rect rect, short w, short h);

l_rect t_edge(l_rect rect, short h);
l_rect r_edge(l_rect rect, short w);
l_rect b_edge(l_rect rect, short h);
l_rect l_edge(l_rect rect, short w);