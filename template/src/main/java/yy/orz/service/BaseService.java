package yy.orz.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

/**
 * Created by YYOrz on 14-5-13.
 */
public abstract class BaseService {

    protected Logger logger = LoggerFactory.getLogger(this.getClass());

    protected PageRequest buildPageRequest(int pageNumber, int pageSize) {
        Sort sort;
        sort = new Sort(Sort.Direction.DESC, "id");

        return new PageRequest(pageNumber - 1, pageSize, sort);
    }

    protected PageRequest buildPageRequest(int pageNumber, int pageSize, Sort sort) {

        return new PageRequest(pageNumber - 1, pageSize, sort);
    }
}
