package ro.ubb.catalog.web.converter;

import ro.ubb.catalog.core.model.User;
import ro.ubb.catalog.web.dto.UserDto;

import java.util.Set;
import java.util.stream.Collectors;

/**
 * Created by pae.
 */

public abstract class UserConverter<Model extends User<Long>, Dto extends UserDto>
        extends UserConverterGeneric<Model, Dto> implements Converter<Model, Dto> {

    @Override
    public Model convertDtoToModel(Dto dto) {
        throw new RuntimeException("not implemented");
    }

    @Override
    public Dto convertModelToDto(Model model) {
        throw new RuntimeException("not implemented");
    }

    public Set<Long> convertModelsToIDs(Set<Model> models) {
        return models.stream()
                .map(model -> model.getId())
                .collect(Collectors.toSet());
    }

    public Set<Long> convertDTOsToIDs(Set<Dto> dtos) {
        return dtos.stream()
                .map(dto -> dto.getId())
                .collect(Collectors.toSet());
    }
}
