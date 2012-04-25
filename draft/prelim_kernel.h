int _kern_read(int fh, void *buffer, int read_byte_count);
int _kern_write(int fh, void *buffer, int write_byte_count);
int _kern_seek(int fh, unsigned short seek_direction, int seek_count);
int _kern_open(char *filename, unsinged short mode);
int _kern_close(int fh);
int _kern_stat(char *filename, void *stat_buffer, int buffer_size);
int _kern_stat(int fh, void *stat_buffer, int buffer_size);
