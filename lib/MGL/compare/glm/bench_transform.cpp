// Bench transformation matrix computation for a list of entities.
// https://glm.g-truc.net
#include <iostream>
#include <sstream>
#include <ctime>
#include <cstdlib>
#include <vector>
#include <glm/glm.hpp>
#include <glm/ext.hpp>

struct Entity{
  glm::vec3 position, rotation, scale;
  glm::mat4 transform;
};

float randf(){ return rand()/(float)RAND_MAX; } 

int main(int argc, char **argv)
{
  std::stringstream ss(argc > 1 ? argv[1] : "1000");
  size_t n;
  ss >> n;

  std::vector<Entity> entities(n);
  for(size_t i = 0; i < entities.size(); i++){
    entities[i].position = glm::vec3(randf(), randf(), randf());
    entities[i].rotation = glm::vec3(randf(), randf(), randf());
    entities[i].scale = glm::vec3(randf(), randf(), randf());
  }

  clock_t start = clock();
  glm::vec3 ax(1,0,0), ay(0,1,0), az(0,0,1);
  
  for(int i = 0; i < 600; i++){
    for(int j = 0; j < entities.size(); j++){
      Entity &e = entities[j];
      e.transform = glm::translate(glm::mat4(), e.position) //
        * glm::rotate(glm::mat4(), e.rotation.x, ax)
        * glm::rotate(glm::mat4(), e.rotation.y, ay)
        * glm::rotate(glm::mat4(), e.rotation.z, az)
        * glm::scale(glm::mat4(), e.scale);

      /*
      glm::mat4 m;
      m = glm::scale(m, e.scale);
      m = glm::rotate(m, e.rotation.z, az);
      m = glm::rotate(m, e.rotation.y, ay);
      m = glm::rotate(m, e.rotation.x, ax);
      m = glm::translate(m, e.position);
      e.transform = m;
      */
    }
  }

  double s = ((double)(clock()-start))/CLOCKS_PER_SEC;
  double ms = s/600.0*1e3;

  std::cout << "10s of 60 FPS ticks (600) with " << n << " entities: ~" << ms << " ms/tick (~" << ceil(ms*6) << "% frame)" << std::endl;

  return 0;
}
