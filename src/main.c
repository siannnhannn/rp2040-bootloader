#include <stdio.h>
#include "app/app_header.h"

_Noreturn void boot_app(const app_header_t *header);

int main () {
	boot_app(&app_header);
}
