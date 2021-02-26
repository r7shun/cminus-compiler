#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>

#include "common.h"

int getAllTestcase(char filename[][256])
{
	int files_count = 0;
	DIR *d = opendir("./testcase/");
    if (d == NULL) {
        perror("opendir error!");
        exit(1);
    }
    struct dirent* entry;
    while ((entry = readdir(d)) != NULL) {
        if (strstr(entry->d_name, ".cminus")) { 
            /* check if this filename has a .cminus suffix match, if then, copy to 
             * filename array and add 1 to files_count
             */
            strcpy(filename[files_count++], entry->d_name);
        }
    }
    closedir(d);
	/// \todo student should fill this function
	return files_count;
}

