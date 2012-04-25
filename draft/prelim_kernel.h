int read(int fh, void *buffer, int read_byte_count);
int write(int fh, void *buffer, int write_byte_count);
int seek(int fh, unsigned short seek_direction, int seek_count);
int open(char *filename, unsinged short mode);
int close(int fh);
int stat(char *filename, void *stat_buffer, int buffer_size);
int stat(int fh, void *stat_buffer, int buffer_size);
