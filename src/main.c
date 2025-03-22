#include <stdio.h>
#include "app/app_header.h"

bool check_app_version(const app_header_t header) {
	if (header.magic != APP_HEADER_MAGIC) {
		return false;
	}
	if (header.version.major != APP_HEADER_VERSION_MAJOR) {
		return false;
	}
	if (header.version.minor != APP_HEADER_VERSION_MINOR) {
		return false;
	}
	return true;
}

int main() {
	if(!(check_app_version(app_header))) {
		while(1);
	}

	app_header.app_entry();

	return 0;
}

