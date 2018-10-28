package ro.ubb.catalog.core.service;

import ro.ubb.catalog.core.model.Announcement;

import java.util.List;

/**
 * Created by hd on 28-May-17.
 */

public interface AnnouncementService {
    List<Announcement> findAll();
    Announcement findAnnouncement(Long announcementId);
    Announcement updateAnnouncement(Long announcementId,String title,String desc);
    Announcement createAnnouncement(String title,String desc);
    void deleteAnnouncement(long id);
}
