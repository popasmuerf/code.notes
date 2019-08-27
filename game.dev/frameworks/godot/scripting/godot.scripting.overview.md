url: https://docs.godotengine.org/en/3.1/getting_started/step_by_step/scripting_continued.html

Processing 
======================================

Several actions in Goot are triggere by callbacks or virtual functions,
so there is no need to write code that runs all the time.



However, if is still common to need a sript to be preicessed on every frame,
there are two tyhpes of processing:

	- idel pocessing 
	- physics processing




Idle processing
====================================
	- is activated when the method Node._process() is found in a script
	- it can be turned off and on with the3 Node.set_process() function.


#GD Script
func _process(delta):
	# Do something

	pass

//csharp

override void _Process(float delta){
	//do someting
	//pass
}



It is important to bear in mind that th efrequency with which _process()
will be called depeneds on howmany frames pers second(FPS) your application 
is running at.  This rate can vary over time an efices.


To help manage this variablility th eeltat parameter contins the 
time elapsed in seons, as a floating point, sinc the previous call
to _process().



this parameter can be used to make sure things always take the same amount of time, regardless of the game's FPS


For example, movement is often miltipled with the time delta to make 
movement speed both constant and independent of th frame rate.




Physics processing wit h_physics_process() is similar, but it shold be
used for processes that must happend before each physics step and it is 
called at fixed time intervals: 60 times per second by default.

The Function _process(), however is not synced with physics.  Its frame rate 
is not constant and is dependent on hardware and game optimiatzation.  It's execution is
done after the phyics step on single threaed games.



A simple way to see the _process() function at work is to create a sene with
a single Label noe, with the following script


#GDScript

extends Label

var accum = 0 

func _process(delta):
	accum += delta
	text = str(accum)




//csharp


public class CustomLabel : Label{
	private float _accum = 0  ;
	overrided public void _Process(float delta){
		_accum += delta ;
		this.text = accum.toString() ;
	}
}



Groups
======================================================
Groups in Godot work like tags you might have come across in other software.
A node can be added to as many groups  This is a useful feature for
organizing large senes.  there are two ways to add
nodes to groups.  The fist is form th UI, using the Groups button uner Node panel


Adding a node to a group programmatically....
--------------------------------------------------------

#GDScript

func _ready():
	add_to_group("enemies")


//csharp


public class CustomLabel : Label{
	
	base._Ready() ;
	AddToGroup("enemies") ;
}



Example....alerting all enemie nodes of your precense once you have been detected...
========================================================================================

#GDScript

func _on_discovered():
	get_tree().call_group("enemies", "player_was_discovered")



//csharp


public void _On_discovered(){
	Get_Tree().CallGroup("enemies", "player_was_discovere") ;
}




Getting a full list of enemy nodes 
==============================================================================
#GDScript

var enemiesList = get_tree(0.get_nodes_in_group("enemies")


//cshapr

var enemiesList = GetTree().GetNodesInGroup("enemies") ;



About the SceneTree class...
============================================================================
The SceneTree class provides many useful methods, like interacting with
scenes, their node hierarchy and groups of nodes.  It allows you to 
easily switch senes or reload them, to quit th egame or pause and unpause it.
It enven comes with interesting signals.  So checkit out if you have some time!!!!




Overridaeable functions
=====================================
all of which can be applied to nodes...



_enter_tree():
	*	called when a node enters a scene tree
	*	childnodes have not entered the scene yet
	*	best used incide _ready() in most cases


_ready():
	*	ensures that all children nodes have also entere 
		the sence tree and became active
	*	called after _enter_tree

_exit_tree()
	*	called when a node exists the scene tree
	*	child nodes have all exited the scene tree at this poing
	*	all nodes have become inactive


_process(float delta)
	*	called for every frame

_phyics_process(float delta)
	*	called for every physics frame



^^^ it's best to use these instead of the notification system.




Creating nodes programmaticallly
================================================

#GDScript


var s 
func _ready():
	s = Sprite.new()
	add_child(s)


//csharp

private Sprite _sprite ;

override public void base._Ready(){
	_sprite = new Sprite() ;
	AddChild(_sprite) ;
}


deletign nodes programmaticallly(and subsequently all of it's child nodes)
================================================

#GDScript

func _someaction():
	s.free()



//csharp

public void _SomeAction(){

	_sprite.Free() ;
}




If a child node is blocking and it has been removed due to 
an ancestor node being removed...the game will crash...
best to remove a node is this way...
================================================

public void _SomeAction(){

	_sprite.QueueFree() ;
}




Instancing scenes
===========================================================
var scene = GD.Load<PackedScene>("res://myscene.tscn")  //the scene isn't  a node yet...


var node scene.Instance() ;
Addchild(node)








