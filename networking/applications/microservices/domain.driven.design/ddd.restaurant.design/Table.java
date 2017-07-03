public class Table extends BaseEntity<Long>{
	private int capacity;
	public Table(String name, Long id, int capacity){
		super(id, name);
		this.capcity = capicity;
	}
	public Long getCapacity(){
		return capacity
	}
	public void setCapacity(int capacity){
		this.capacity = capcity
	}
}