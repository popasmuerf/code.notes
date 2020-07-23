using Area2D



public class Player: Area2D {


	[Export]
	public int speed ;
	public Vector2  _screensize ;



	public void Ready(){
		screensize = GetViewPort()
			     .GetSize() ;
	}



	public void Process(float delta){
		/*create a new Struct of type Vector2 */
		Vector2 velocity = new Vector2() ;
		/* update posistion of sprite based on unser input  */
		if(Input.IsActionPressed("ui_right"){velocity.x += 1 ;}
		if(Input.IsActionPressed("ui_left"){velocity.x += -1 ;}
		if(Input.IsActionPressed("ui_up"){velocity.y += 1 ;}
                if(Input.IsActionPressed("ui_down"){velocity.y += -1 ;}	


		/*If the new state of the location of the sprite has changed...
                  then then the magnitude(Length) of the vector should be > 0 
                  ...if it is then then get a reference to the sprite's object
                  from the game engine and set it to "play"...i.e the engine
                  will then will know to animate the sprite when it reads the
                  Position struct  */
		/*We check each input and add./subtract fromt eh velocity to obtain a
		  total direction.  For example, if you hold right and down at the same
                  time, the reulsting velocity vectory will be (1,1).  In this case, since
                  we are adding a horizontal and vertical movement, the player would move
                  faster than if it just moved horizontally.

		  We can prevent that if we normalize the velocity, which means we
                  set it's lenth to 1 and multply by the desired speed.  This means no more
                  fast diagonal movement, or rather...we intentially slow the speed of diagonal
                  movement to that of 1 dimensional movement.
		 
		*/
		if(velocity.length > 0){
			velocity = velocity.normalized() * speed ;
			var animatedSprite = GetNode<AnimatedSprite>("AnimatedSprite") ;
			animatedSprite.play();
		}else{
			animatedSprite.stop() ;
		}

		/*Now that we have movement direction, we can update a Player's
		  posistion and use clame() to prevent it from leaving the screen by adding
                  the following to the bottom of the _process function.
		  To "clamp" here means restricting a sprite to a given range*/
		Position += velocity * delta ;
		Position = new Vector2(x:Math.Clamp(Posistion.x,0,_screenSize.x),
				       y:Mathf.Clamp(Posistion.y,0, _screenSize.y);


		/*Now that the player can move, we need to change which animation the
		  AnimatedSprite is playing based on direction.  We have a "right" animation
                  which should be flipped horizontally using the flip_h property for left
                  movement, and an "up" animation, which should  be flipped vertically with 
                  flph_v for downward movement.  Let's place this code at the end of our
                  _process()*/

		if(velocity.x !=0){
			animatedSprite.Animation = "right" ;
			animatedSprite.FlipH = velocity.x < 0 ;
			animatedSprite.FliphV = false ;
		}else if(velocity.y != 0){
			animatedSprite.Animation = "up" ;
			animationSprite.FlipV= velocity.y > 0 ;
		}
			
	}



}
