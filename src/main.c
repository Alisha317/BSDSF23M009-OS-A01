#include <stdio.h>
#include <stdlib.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main() {
    printf("--- Testing String Functions ---\n");

    char source[] = "Hello";
    char dest[50];
    int len;

    len = mystrlen(source);
    printf("mystrlen(\"%s\") = %d\n", source, len);

    mystrcpy(dest, source);
    printf("mystrcpy result: %s\n", dest);

    char dest2[50];
    mystrncpy(dest2, "HelloWorld", 5);
    printf("mystrncpy (first 5 chars of \"HelloWorld\"): %s\n", dest2);

    char cat_dest[50] = "Hello, ";
    mystrcat(cat_dest, "World!");
    printf("mystrcat result: %s\n", cat_dest);

    printf("\n--- Testing File Functions ---\n");

    FILE* fp = fopen("test.txt", "w");
    if (fp != NULL) {
        fprintf(fp, "Hello World\nThis is a test file\nHello again\nSearching for hello\n");
        fclose(fp);
    }

    fp = fopen("test.txt", "r");
    if (fp == NULL) {
        printf("Error opening file\n");
        return 1;
    }

    int lines, words, chars;
    if (wordCount(fp, &lines, &words, &chars) == 0) {
        printf("Lines: %d, Words: %d, Characters: %d\n", lines, words, chars);
    } else {
        printf("wordCount failed\n");
    }

    char** matches;
    int match_count = mygrep(fp, "Hello", &matches);
    printf("mygrep found %d matches for \"Hello\":\n", match_count);
    for (int i = 0; i < match_count; i++) {
        printf("  %s", matches[i]);
        free(matches[i]);
    }
    if (match_count > 0) {
        free(matches);
    }

    fclose(fp);

    return 0;
}
