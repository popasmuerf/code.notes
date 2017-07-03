public interface ReadOnlyRepository<TE,T>{
	boolean contains(T id);
	Entity get(T id );
	Collection<TE> getAll();
}