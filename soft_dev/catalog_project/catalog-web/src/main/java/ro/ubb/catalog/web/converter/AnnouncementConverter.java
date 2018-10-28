package ro.ubb.catalog.web.converter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import ro.ubb.catalog.core.model.Announcement;
import ro.ubb.catalog.web.dto.AnnouncementDto;

import java.util.Collection;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Created by hd on 28-May-17.
 */

@Component
public class AnnouncementConverter implements ConverterGeneric<Announcement,AnnouncementDto>{
    private static final Logger log = LoggerFactory.getLogger(AnnouncementConverter.class);


    @Override
    public Announcement convertDtoToModel(AnnouncementDto announcementDto) {
        return null;
    }

    @Override
    public AnnouncementDto convertModelToDto(Announcement announcement) {
        AnnouncementDto announcementDto = AnnouncementDto.builder()
                .title(announcement.getTitle())
                .descr(announcement.getDescr())
                .build();
        announcementDto.setId(announcement.getId());
        return announcementDto;
    }

    public Set<AnnouncementDto> convertModelsToDtos(Collection<Announcement> models) {
        return models.stream()
                .map(model -> convertModelToDto(model))
                .collect(Collectors.toSet());
    }

    public java.util.Set<Announcement> convertDtosToModel(Collection<AnnouncementDto> dtos) {
        return dtos.stream()
                .map(dto -> convertDtoToModel(dto))
                .collect(Collectors.toSet());
    }
}
