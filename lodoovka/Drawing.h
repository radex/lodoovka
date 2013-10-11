//
//  Drawing.h
//  lodoovka
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "Geometry.h"

void setColor(unsigned char r, unsigned char g, unsigned char b);
void setGrey(unsigned char g);
void drawRect(short x, short y, short w, short h);
void drawRectr(l_rect rect);
void drawLineH(short x, short y, short l);
void drawLineV(short x, short y, short l);