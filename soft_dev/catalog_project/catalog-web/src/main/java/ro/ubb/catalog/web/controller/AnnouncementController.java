package ro.ubb.catalog.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ro.ubb.catalog.core.model.Announcement;
import ro.ubb.catalog.core.service.AnnouncementService;
import ro.ubb.catalog.web.converter.AnnouncementConverter;
import ro.ubb.catalog.web.dto.AnnouncementDto;
import ro.ubb.catalog.web.dto.AnnouncementsDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hd on 28-May-17.
 */

@RestController
public class AnnouncementController {

    private static final Logger log = LoggerFactory.getLogger(AnnouncementController.class);

    @Autowired
    private AnnouncementService announcementService;

    @Autowired
    private AnnouncementConverter announcementConverter;

    @RequestMapping(value = "/announcements", method = RequestMethod.GET)
    public AnnouncementsDto getAnnouncements() {
        log.trace("getAnnouncements");
        List<Announcement> announcements = announcementService.findAll();
        log.trace("getAnnouncements: announcemets={}", announcements );
        return new AnnouncementsDto(announcementConverter.convertModelsToDtos(announcements));
    }

    @RequestMapping(value = "/announcements/{announcementId}", method = RequestMethod.PUT)
    public Map<String, AnnouncementDto> updateAnnouncement(
            @PathVariable final Long announcementId,
            @RequestBody final Map<String, AnnouncementDto> announcementDtoMap) {

        log.trace("updateAnnouncement: announcementId={}, announcementDtoMap={}", announcementId, announcementDtoMap);

        AnnouncementDto announcementDto = announcementDtoMap.get("announcement");
        Announcement announcement = announcementService.updateAnnouncement(announcementId, announcementDto.getTitle(), announcementDto.getDescr());

        Map<String, AnnouncementDto> result = new HashMap<>();
        result.put("announcement", announcementConverter.convertModelToDto(announcement));

        log.trace("updateAnnouncement: result={}", result);
        return result;
    }

    @RequestMapping(value = "/announcements", method = RequestMethod.POST)
    public Map<String, AnnouncementDto> createAnnouncement(
            @RequestBody final Map<String, AnnouncementDto> announcementDtoMap) {

        log.trace("createAnnouncement: announcementDtoMap={}", announcementDtoMap);

        AnnouncementDto announcementDto = announcementDtoMap.get("announcement");
        Announcement announcement = announcementService.createAnnouncement(announcementDto.getTitle(), announcementDto.getDescr());

        Map<String, AnnouncementDto> result = new HashMap<>();
        result.put("announcement", announcementConverter.convertModelToDto(announcement));

        log.trace("updateAnnouncement: result={}", result);
        return result;
    }
}
