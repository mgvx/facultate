package ro.ubb.catalog.web.converter;

/**
 * Created by pae.
 */
public interface ConverterGeneric<Model, Dto> {
    Model convertDtoToModel(Dto dto);
    Dto convertModelToDto(Model model);
}
