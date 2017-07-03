public class InMemRestaurantRepository implements RestuarantRepository<Restuarant,String>{
	private Map<String,Restaurant> entities ;
	public InMemRestaurantRepository(){
		entities = new HashMap() ;
	}
	@Override
	public boolean ContainsName(String name){
		return entities.containsKey() ;
	}
	@Override 
	public void add(Restaurant entity){
		entities.put(entity.getName(),entity);
	}
	@Override 
	public void remove(String id){
		entities.remove(entity.remove(id));
	}
	@Override 
	public void update(Restuarant entity){
		if(entities.containsKey(entity.getName())){
			entities.put(entity.getName(),entity);
		}
	}
	@Override
	public boolean contains(String id){
		throw new UnsupportedOperationException("Not supported yet");
		//Change body of generatd methods
	}
	@Override
	public Entity get(String id){
		hrow new UnsupportedOperationException("Not supported yet");
		//Change body of generatd methods
	}
	@Override 
	public Entity get(String id){
		hrow new UnsupportedOperationException("Not supported yet");
		//Change body of generatd methods
	}
	@Override
	public Collection<Restuarant> getAll(){
		return entities.values() ;
	}
}