package ro.ubb.catalog.core.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ro.ubb.catalog.core.model.Announcement;
import ro.ubb.catalog.core.repository.AnnouncementRepository;

import java.util.List;


/**
 * Created by hd on 28-May-17.
 */

@Service
public class AnnouncementServiceImpl implements AnnouncementService{
    private static final Logger log = (Logger) LoggerFactory.getLogger(AnnouncementServiceImpl.class);

    @Autowired
    private AnnouncementRepository announcementRepository;

    @Override
    public List<Announcement> findAll() {
        log.trace("findAll");
        List<Announcement> announcements = announcementRepository.findAll();
        log.trace("findAll: announcements={}", announcements);
        return announcements;
    }

    @Override
    public Announcement findAnnouncement(Long announcementId) {
        log.trace("findAnnouncement: announcementId={}", announcementId);
        Announcement announcement = announcementRepository.findOne(announcementId);
        log.trace("findStudent: student={}", announcement);
        return announcement;
    }

    @Override
    public Announcement updateAnnouncement(Long announcementId, String title, String descr) {
        log.trace("updateAnnouncement: announcementId={}, title={}, descr={}",announcementId, title, descr);
        Announcement announcement = announcementRepository.findOne(announcementId);
        announcement.setTitle(title);
        announcement.setDescr(descr);
        log.trace("upadeteAnnouncement: announcement={}",announcement);
        return announcement;
    }

    @Override
    public Announcement createAnnouncement(String title, String descr) {
        log.trace("createAnnouncement: title={} ", title);
        Announcement announcement = Announcement.builder()
                .title(title)
                .descr(descr)
                .build();

        announcement = announcementRepository.save(announcement);
        log.trace("createAnnouncement: announcement={}",announcement);
        return announcement;
    }

    @Override
    public void deleteAnnouncement(long id) {
        log.trace("deleteAnnouncement: announcementId={}", id);
        announcementRepository.delete(id);
        log.trace("deleteAnnouncement - method end");
    }
}
