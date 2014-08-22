package yy.orz.dao;

import org.springframework.data.repository.PagingAndSortingRepository;
import yy.orz.domain.User;

public interface UserDao extends PagingAndSortingRepository<User, Long> {
	User findByLoginName(String loginName);
}
