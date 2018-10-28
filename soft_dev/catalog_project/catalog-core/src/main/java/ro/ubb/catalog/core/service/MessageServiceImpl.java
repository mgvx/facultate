package ro.ubb.catalog.core.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ro.ubb.catalog.core.model.Message;
import ro.ubb.catalog.core.repository.MessageRepository;

import java.util.List;


/**
 * Created by hd on 28-May-17.
 */

@Service
public class MessageServiceImpl implements MessageService{
    private static final Logger log = (Logger) LoggerFactory.getLogger(MessageServiceImpl.class);

    @Autowired
    private MessageRepository messageRepository;

    @Override
    public List<Message> findAll() {
        log.trace("findAll");
        List<Message> messages = messageRepository.findAll();
        log.trace("findAll: messages={}", messages);
        return messages;
    }

    @Override
    public Message findMessage(Long messageId) {
        log.trace("findMessage: messageId={}", messageId);
        Message message = messageRepository.findOne(messageId);
        log.trace("findStudent: student={}", message);
        return message;
    }

    @Override
    public Message updateMessage(Long messageId, String text) {
        log.trace("updateMessage: messageId={}, title={}, desc={}",messageId, text);
        Message message = messageRepository.findOne(messageId);
        message.setText(text);
        log.trace("upadeteMessage: message={}",message);
        return message;
    }

    @Override
    public Message createMessage(String text, Long fromId, Long toId) {
        log.trace("createMessage: text,fromId,toId ={} ", text,fromId,toId);
        Message message = Message.builder()
                .text(text)
                .fromId(fromId)
                .toId(toId)
                .build();

        message = messageRepository.save(message);
        log.trace("createMessage: message={}",message);
        return message;
    }

    @Override
    public void deleteMessage(long id) {
        log.trace("deleteMessage: messageId={}", id);
        messageRepository.delete(id);
        log.trace("deleteMessage - method end");
    }
}
