public abstract class BaseEntity<T> extends Entity<T>{
	private T id ;
	public BaseEntity(T id, String name){
		super.id = id ;
		super.name = name ;
	}
	public T getId(){
		return id ;
	}
	public void setId(T id ){
		this.id = id ;
	}
}