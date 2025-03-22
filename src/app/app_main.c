#include <stdint.h>
#include "app_header.h"

void _start(void);

int main() {
    while (1);
    return 0;
}

__attribute__((section(".app_header"))) const app_header_t app_header = {
    .magic   = APP_HEADER_MAGIC,
    .version = {
        .major = APP_HEADER_VERSION_MAJOR,
        .minor = APP_HEADER_VERSION_MINOR,
        .patch = APP_HEADER_VERSION_PATCH,
    },
    .app_entry = _start,
};
