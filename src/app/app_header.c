#include <stdint.h>
#include "app_header.h"

_Noreturn void _start(void);

const app_header_t app_header = {
    .magic   = APP_HEADER_MAGIC,
    .version = {
        .major = APP_HEADER_VERSION_MAJOR,
        .minor = APP_HEADER_VERSION_MINOR,
        .patch = APP_HEADER_VERSION_PATCH,
    },
    .app_entry = _start,
};
