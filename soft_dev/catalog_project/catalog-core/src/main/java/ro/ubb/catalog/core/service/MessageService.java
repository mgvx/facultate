package ro.ubb.catalog.core.service;

import ro.ubb.catalog.core.model.Message;

import java.util.List;

/**
 * Created by hd on 28-May-17.
 */
public interface MessageService {
    List<Message> findAll();
    Message findMessage(Long messageId);
    Message updateMessage(Long messageId,String text);
    Message createMessage(String title,Long from,Long to);
    void deleteMessage(long id);
}
