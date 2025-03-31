#include <stdio.h>
#include "app/app_header.h"

enum boot_error {
    BOOT_ERROR_INVALID_MAGIC,
    BOOT_ERROR_MAJOR_VERSION,
    BOOT_ERROR_MINOR_VERSION,
    BOOT_ERROR_PATCH_VERSION,
};

static int validate_app_header(const app_header_t *header) {
    if (header->magic != APP_HEADER_MAGIC) {
        return BOOT_ERROR_INVALID_MAGIC;
    }

    if (header->version.major != APP_HEADER_VERSION_MAJOR) {
        return BOOT_ERROR_MAJOR_VERSION;
    }

    if (header->version.minor < APP_HEADER_VERSION_MINOR) {
        return BOOT_ERROR_MINOR_VERSION;
    }

    if (header->version.patch < APP_HEADER_VERSION_PATCH) {
        return BOOT_ERROR_PATCH_VERSION;
    }
    return 0;
}

_Noreturn void boot_app(const app_header_t *header) {
	header->app_entry();
}
