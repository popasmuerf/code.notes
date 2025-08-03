[3D Math Primer for Game Programmers (Coordinate Systems)](https://www.3dgep.com/3d-math-primer-for-game-programmers/)

### World space
- Golbal coordinate system for he entire scene.
- It's the reference frame for all objecsts and the camera 
- The origin (0,0,0) is suually at the center of the scene, and all
objects are positioned and oriented relative to this global origin.

### Object Space (or Model Space)
- This is a local coordinate system specific to each object
- The orgigin of object space is ususally at the center of the object
- coordinates of the object's vertices are defined relative to this origin


### Camera Space (or View Space)
- Space defined from the camera's perspective. 
- The camera is placed at the origin (0,0,0)
- coordinates of objects are transformed to be relative to th ecamera's position and orientation.
- The z-axis typically points along the camera's direction.


### Internal Space :
- This coordinate system used internally by rendering engines, such as Mental Ray,
for calculations related to shaders and other rendering processes. 
- varies fbetween different engines and versions, and shaders should not assume it's the same as world space.



### Transformations between spaces 
- To render a scene, objects need to be transformed from their object space to world space
and then to camera space.
- Finally, the camera space coordnates are transformed to screen space (2D) for dsplay.

#### Object to World:
    - Involves translation and rotating the object to its poistion and ortientation in the world.
    - This uses a "model" matrix. 

#### World to Camera
Transforms the world coordinates to be relative tot he camer's position and orientation.





This is often referred to as "view" or "camera" matritx 

#### Camera to Screen :

Proejects the D3 camera coordinates onto a 2D screen, handling perspective and other projection effects 


#### 

