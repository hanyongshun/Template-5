package yy.orz.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

/**
 * Created by YYOrz on 14-5-13.
 */
@Service
public abstract class BaseService<T> {

    @Autowired
    protected JpaRepository<T, Long> repository;

    public T findOne(Long id) {
        return repository.findOne(id);
    }

    public void delete(Long id) {
        repository.delete(id);
    }

    public void saveOrUpdate(T o) {
        repository.save(o);
    }
}
