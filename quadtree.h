struct actor{
    int x, y;
	int w, h;
    int position;
    int speed;
    struct actor *next;
};

struct quadtree{
    struct quadtree *left, *top, *right, *down;
    struct actor *list;
};

struct actor* create_actor();
int init_actor(struct actor *a);
int move_actor(struct actor *a, int position, int speed);
int stop_actor(struct actor *a);

struct quadtree* create_quadtree();
int free_quadtree(struct quadtree * qt);
int init_quadtree(struct quadtree * qt);
int insert_actor(struct actor *a);
int update_actor(struct actor *a);
int run_quadtree(struct quadtree * qt);
