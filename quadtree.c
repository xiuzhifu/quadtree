#include<stdio.h>
#include "quadtree.h"
static quadtree Q;
static int W = 10;
static int H = 10;
struct actor* create_actor(){
    struct actor * a = (void*)malloc(sizeof(struct actor));
    init_actor(a);
    return a;
}

int init_actor(struct actor *a){
    memset(a, sizeof(struct actor), 0);
    a->w = 1;
    a->h = 1;
    return 0;
}

int move_actor(struct actor *a, int position, int speed){
    if(!a) return -1;
    a->position = position;
    a->speed = speed;
}

int stop_actor(struct actor *a){
	a->speed = 0;
}

struct quadtree*  create_quadtree(){
	struct quadtree* qt = (void*)malloc(sizeof(struct quadtree));
}

int free_quadtree(struct quadtree * qt){
	if (!qt) return -1;
	if (qt->left) free_quadtree(qt->left);
	if (qt->top) free_quadtree(qt->top);
	if (qt->right) free_quadtree(qt->right);
	if (qt->down) free_quadtree(qt->down);

	free(qt);
	return 0;
}
int init_quadtree(struct quadtree * qt){
    memset(qt, sizeof(struct quadtree), 0);
    return 0;
}

int update_actor(struct actor *a){

}

int run_quadtree(struct quadtree * qt){

}
int main(void){
}
