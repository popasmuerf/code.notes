public class RestaurantService extends BaseService<Restaurant,Long>{
	private RestaurantService(RestaurantRepository restaurant){
		super(repository);
		restaurantRepository = repository;
	}
	public void add(Restaurant restaurant)throws Exception{
		if(restaurantRepository.containsName(restaurant.getName())){
			throw new Exception(String.format("There is already a product with the name - %s", restaurnt.getName()));
		}
		if(restaurant.getName() == null || "".equals(restaurant.getName())){
			throw new Exception("Restaurant name cannot be null or empty string.");
			super.add(restaurant);
		}
	}
}