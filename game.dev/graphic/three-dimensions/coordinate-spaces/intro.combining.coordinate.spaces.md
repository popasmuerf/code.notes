[3D Math Primer for Game Programmers (Coordinate Systems)](https://www.3dgep.com/3d-math-primer-for-game-programmers/)


- In 3D computer graphics, coordinate spaces are described using a homogenous coordinate system.
- A homogeneous coordintate system allows us to prepresent all of our affine transformations 
    * translation
    * rotation 
    * scale
    * pperspective projection


in a similar way so they can easly be combined into a single representation.

- Any number coordinate spaces  can be combined using matrix multiplication which results in 
a single matrix that can be applied to all th evertices of an object.

- Even multiple world coordinate spaces can be combined in order to derive a final coordinate space
that describes the location fo all of our vertices in an object.
- This is useful for nested coordiante spaces wher the position of an object is expressed relative to a "parent" object.
- when the partent object's world transform is changed, the transform of the child object is also changed implicityly.
Using this method, complex senes can be constructed form several smaller scenes and placed in to the larger
scene to create a complete world.