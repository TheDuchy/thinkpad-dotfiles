

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

unsigned long long analizefileOSHahs(char *fileName){
	/*
	* Public Domain implementation by Kamil Dziobek. turbos11(at)gmail.com
	* This code implements Gibest hash algorithm first use in Media Player Classics
	* For more implementation(various languages and authors) see:
	* http://trac.opensubtitles.org/projects/opensubtitles/wiki/HashSourceCodes
	*
	* -works only on little-endian procesor DEC, Intel and compatible
	* -sizeof(unsigned long long) must be 8
	*/

	FILE				*file;
	int i;
	unsigned long long t1=0;
	unsigned long long buffer1[8192*2];
	file = fopen(fileName, "rb");
	fread(buffer1, 8192, 8, file);
	fseek(file, -65536, SEEK_END);
	fread(&buffer1[8192], 8192, 8, file);
	for (i=0;i<8192*2;i++)
		t1+=buffer1[i];
	t1+= ftell(file); //add filesize
	fclose(file);
	return	t1;
};
int main(int argc, char *argv[]){
	assert(sizeof(unsigned long long) == 8);
	if (argc < 2){
		puts("Enter file path as the first argument!");
		exit(1);
	}
	unsigned long long myhash=analizefileOSHahs(argv[1]);
	printf("%llx",myhash);
}

