public class Restaurant extends BaseEntity<Long>{
	private Long id ;
	private List<Table> tables = new ArrayList<>() ;
	public Restaurant(Long id, String name,List<Table> tables){
		super.id = id;
		super.name = name;
		this.tables = tables;
	}
	public Long getId(){
		return id;
	}
	public void setId(Long id ){
		this.id = id;
	}
	pubic List<Table> getTables(){
		return tables;
	}
	public void setTables(List<Tables> tabls){
		this.tables = tables ;
	}
}