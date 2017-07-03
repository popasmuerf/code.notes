public abstract class BaseService<TE,T> extends ReadOnlyBaseService<TE,T>{
	private Repository<TE,E> _repository;
	BaseService(Repository<TE,T> repository){
		super(repository);
		_repository = repository ;
	}
	public void add(TE entity)throws Exception{
		_repository.add(entity);
	}
	public Collection<TE> getAll(){
		return _repository.getAll() ;
	}
	//....Do stuff....
}