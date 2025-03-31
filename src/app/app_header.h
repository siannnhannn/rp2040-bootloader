#ifndef APP_HEADER
#define APP_HEADER

#include <stddef.h>
#include <stdint.h>
#include <assert.h>

#define APP_HEADER_MAGIC (('m' << 24) | ('e' << 16) | ('o' << 8) | 'w')
#define APP_HEADER_VERSION_MAJOR 1 
#define APP_HEADER_VERSION_MINOR 1
#define APP_HEADER_VERSION_PATCH 0

typedef struct app_header_version {
    uint32_t major;
    uint32_t minor;
    uint32_t patch;
} app_header_version_t;

static_assert(offsetof(app_header_version_t, major) == 0x00, "offsetof(app_header_version_t, major) != 0x00");
static_assert(offsetof(app_header_version_t, minor) == 0x04, "offsetof(app_header_version_t, minor) != 0x04");
static_assert(offsetof(app_header_version_t, patch) == 0x08, "offsetof(app_header_version_t, patch) != 0x08");

typedef void (app_entry_t)(void);

typedef struct app_header {
    uint32_t magic;
    app_header_version_t version;
    app_entry_t *app_entry;
} app_header_t;

static_assert(offsetof(app_header_t, magic) == 0x00, "offsetof(app_header_t, magic) != 0x00");
static_assert(offsetof(app_header_t, version) == 0x04, "offsetof(app_header_t, version) != 0x04");
static_assert(offsetof(app_header_t, app_entry) == 0x10, "offsetof(app_header_t, app_entry) != 0x10");

extern const app_header_t app_header; 
#endif // APP_HEADER
