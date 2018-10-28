package ro.ubb.catalog.web.converter;

import ro.ubb.catalog.core.model.User;
import ro.ubb.catalog.web.dto.UserDto;

/**
 * Created by pae.
 */

public interface Converter<Model extends User<Long>, Dto extends UserDto>
        extends ConverterGeneric<Model, Dto> {

}

