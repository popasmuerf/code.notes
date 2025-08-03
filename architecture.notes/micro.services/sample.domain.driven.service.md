# Sample domain service

- Based on discussed reservation system
- Projects developed based on the domain layer are more maintainable, highly cohesive and decoupled.
- They provide high scalabilityin terms of business requirement change and have a low imppat on the design of other layers



- Domain-driven development is based on the domain, hence it is not recommended that you use a top-down approach
where the UI would be developed first, followed by the rest of the layers and finally the presistence layer.



# Entity implementation



### Base class for all entities


        pubic abstract class Entity <T> {
            T id ;
            String name ;
        }


####  Abstract class ClaseBaseEntity extends Abstract class Entity


        public abstract classBaseEntity <T> extends Entity<T>{
            public BaseEntity(T id, String name){
                super.id = id ;
                super.name = name ;
            }

            public int  getId(){
                return super.id  ;
            }
            public void setId(int id){
                super.id = id; 
            }

            public String  getName(){
                return super.id  ;
            }
            public void setName(String name){
                super.name = name; 
            }

        }


Now Senince ware are developing the table reservationsystem, `Table` is another important entity
in terms of the domain model.  If we go by the aggregate pattern, `restaurant` would work 
as a root, and table would be internal to the Restaurant entity.  Therefore, the Table entity
would always be accessable using th eRestuarant entity.


#### Entity Table extends BaseEntity  

public class Table extends BaseEntity<BigInteger>{
    private int capacity ;

    public Table(String Name, BigInteger id, int capacity){
        super(id, name);
        this.capacity = capacity;
    }

    public void setCapacity(int capacity){
        this.capacity = capacity ;
    }

        public int getCapacity(){
        return capacity ;
    }
    
}


#### Aggregator Restaurant

    public class Restuarant extends BaseEntity<String> {

        private List<Table> talbes = new ArrayList<>();

        pubic Restaurant(String name, String, id, List<Table> tables){
            super (id, name);
            this.tables = tables ;
        }

        public void setTables (List<Table) tables){
            this.tables = tables ;
        }


        public List<Table> getTables(){
            return this.tables ;
        }

    }


## REpository implemention.


public interface ReadOnlyRepository<TE, T>{
    boolean contains(T, id);
    Entity get(T, id);
    Collection<TE> getAll();
} 


public interface Repository<TE,T> extends ReadOnly<TE,T> {
    void add(TE entity);
    void remove(T,id);
    void update(TE entity)''
}


public interface RestaurantRepository<Restuarant,String> extends Repository<Restaurant,String>{
    boolean ContainsName(String name);
}


public class InMemRestaurantRepository implements RestaurantRepository<Restaurant, String>{

    private Map<String,Restaurant> entities ;

    public InMemRestuarantRepository(){
        entities = new HashMap();
    }

    @Override 
    public boolean ContainsName(String name){
        return entitities.containsKey(name);
    }

    @Override
    public void add(Restaurant entity){
        entities.put(entity.getName(), entity);
    }

    @Override
    public void remove(String id){
        if(entities.containsKey(id)){
            entities.remove(id);
        }
    }

    @Override 
    public void update(Restaurant entity){
        if(entities.containsKey(entity.getName())){
            entities.put(entity.getName(),entity);
        }
    }

    @Override
    public boolean contains(String id){
        //To change body of generated methods, choose Tools | Templates
        throw new UnsupportedOpertionException("Not supported yet. ");
    }

    @Override
    public Entity get(String id){
                //To change body of generated methods, choose Tools | Templates
        throw new UnsupportedOperationException("Not supported yet.");
    }


        @Override
    public Collection<Restaurant> getAll(){
                //To change body of generated methods, choose Tools | Templates
        return entities.values();
    }

}




## Service implementation 

        public abstract class ReadOnlyBaseService <TE, T> {

            private Repository<TE,T> repository;
            
            ReadOnlyBaseService(Repository<TE,T> repository){
                this.repository = repository ; 
            }
        }

        public abstrace class BaseService <TE, E>  extends ReaOnlyBaseService<TE,T> {

            private Repository<TE,T> _repository ;

            BaseService(Repository<TE,T> repository){
                _repository = repository ;
            }

            public void add (TE entity) throws Exception{
                _repository.add(entity);
            }

            public Collection<TE> getAll(){
                return _repository.getAll();
            }
            
        }



        public class RestaurantService extends BaseService <Restaurant, BigInteger> {

            private RestuarantRepository<Restaurant, String> restaurantRepository; 

            public RestaurantService(RestaurantRepository repository){
                super(repository);
                restaurantRepository = _repository; 
            }


            public void add(Restaurant restaurant){
                throws Exception {
                    if (restaurantRepository.ContainsName(restaurant.getName())){
                        throw new Exception (String.format("There is already a product with the name - %s", restaurant.getName()));
                    }
                    if(restaurant.getName() == null || "".equals(restaurant.getName())){
                        throw new Exeption("Restaurant name cannot be null or empty string.");
                    }
                    super.add(restaurant);
                }

            }


        }


// We should write implementation for the other entities including the Tables.....



























