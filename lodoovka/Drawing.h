#pragma once

#include "Geometry.h"

void startDrawing();

void setColor(unsigned char r, unsigned char g, unsigned char b);
void setGrey(unsigned char g);
void drawRect(short x, short y, short w, short h);
void drawRectr(l_rect rect);
void drawLineH(short x, short y, short l);
void drawLineV(short x, short y, short l);

void finishDrawing();