#define NUM_OF_SHARED_PAGES 8


struct shared_page{
    int id;
    int num_of_refs;
    char* frame;
};