package yy.orz.dao.support;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.io.Serializable;

public interface BaseDao<T, PK extends Serializable> extends PagingAndSortingRepository<T, PK>, JpaSpecificationExecutor<T> {

	
}
