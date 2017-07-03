public interface RestaurantRepository<Restaurant,String> extends ReadOnlyRepository<Restaurant,String>{
	boolean containsName(String name);
}