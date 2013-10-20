#pragma once

#include <stdio.h>
#include <stdarg.h>

int asprintf(char **ret, const char *format, ...);
int vasprintf(char **ret, const char *format, va_list args);

void lodoovka_log(const char *log);
void lodoovka_logf(const char *format, ...);