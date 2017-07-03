public interface ReadOnlyRepository<TE,T> extends ReadOnlyRepository<T,TE>{
	void add(TE entity);
	void remove(T id);
	void update(TE entity);
}