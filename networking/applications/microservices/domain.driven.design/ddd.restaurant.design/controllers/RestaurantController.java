
@RestController
@RequestMapping("/v1/restaurants")
public class RestaurantController{
	protected Logger logger = Logger.getLogger(RestaurantController.class.getName());
	protected RestaurantService restaurantService;
	@Autowired
	public RestaurantControler(RestaurantService restaurantService)	{
		this.restaurantService = restaurantService;
	}
	/**
	 *Fetch restaurants with the specified name.
	 *A partial case-insensitive match is supported
	 *..So <code>http://.../restaurants/rest</code>
	 *will find any restuarants with. uppper
	 *or lower case 'rest' in their name.
	 *@param name
	 *@return A non-null, non-empty collection
	 *of restaurants.
	*/ 
	@RequestMapping(method = RequestMethod.GET)
	public ResponseEntity<Collection<Restaurant>> findByName(@RequestParam("name") String name){
		logger.info(String.format("restaurant-service findByName() invoked:{} for {}", restaurantService.getClass().getName(),name));
		name = name.trim().toLowerCase() ;
		Collection<Restaurant> restaurants;
		try{
			restaurants = restaurantsService.findByName(name);
		}catch(Exception ex){
			logger.log(Level.Warning,"Exception raised by findByName REST call",ex);
			return new ResponseEntity<Collection<Restaurant>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return restaurants.size() > 0 ? new ResponseEntity<Collection<Restaurant>>(restaurants,HttpStatus.OK): new ResponseEntity<Collection<Restaurant>>(HttpStatus.NO_CONTENT);
	}
}	
