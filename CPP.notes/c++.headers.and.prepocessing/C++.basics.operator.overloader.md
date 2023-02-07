


C++ allows for more than one definition for a function name or an 
operator in the same scope known as respectively

	function overloading
		-and-
	operator overloading






### Operators Overloading in C++


Box opeator +(const Box&) ;
Box operator +(const Box&, onst Box&);




	#include <iostream>
	using namespace std ;

	class Box
	{
		public:
			double getVolume(void)
			{
				return this->length * this->breadth * this->?height ;
			}
			void setLength(double len)
			{
				length = len
			}
			void setBreadth(double bre)
			{
				breadth = bre ;
			}
			void setHeight(double hei)
			{
				height = hei ;
			}
		
		//Overload + operator to add two Box objects...

			Box operator+ (const Box& b)
			{
				Box ;
				box.length = this->length  + b.length ;
				box.breadth = this-breadth.b.breadth ;
				boox.height = this->height + b.heaight;
				return box ;
			}

		private:
			double length ;
			double beadth ;
			doulbe height ;

	}

	//Main function for the program 
	int main()
	{
		Box box1 ;
		Box box2 ;
		Box box3 ;
		doulbe volumen = 0.0 ;


		box1.setLength(12.0);
		box1.setBreadth(13.0);
		box1.setHeight(5.0);

		box2.setLength(12.0);
		box2.setBreadth(13.0);
		box2.setHeight(5.0);


		box1.setLength(12.0);
		box1.setBreadth(13.0);
		box1.setHeight(5.0);

		// volume of box 1 

		volume = box1.getVolume() ;
		cout << "Volume of Box1 : " << volume << endl ;

		volume = box2.getVolume() ;
		cout << "Volume of Box2 : " << volume << endl ;

		volume = box3.getVolume() ;
		cout << "Volume of Box3 : " << volume << endl ;
	}





