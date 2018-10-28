package ro.ubb.catalog.web.converter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ro.ubb.catalog.core.model.Message;
import ro.ubb.catalog.web.dto.MessageDto;

import java.util.Collection;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Created by hd on 06-Jun-17.
 */
public class MessageConverter implements ConverterGeneric<Message,MessageDto> {
    private static final Logger log = LoggerFactory.getLogger(MessageConverter.class);


    @Override
    public Message convertDtoToModel(MessageDto messageDto) {
        return null;
    }

    @Override
    public MessageDto convertModelToDto(Message message) {
        MessageDto messageDto = MessageDto.builder()
                .text(message.getText())
                .fromId(message.getFromId())
                .toId(message.getToId())
                .build();
        messageDto.setId(message.getId());
        return messageDto;
    }

    public Set<MessageDto> convertModelsToDtos(Collection<Message> models) {
        return models.stream()
                .map(model -> convertModelToDto(model))
                .collect(Collectors.toSet());
    }

    public java.util.Set<Message> convertDtosToModel(Collection<MessageDto> dtos) {
        return dtos.stream()
                .map(dto -> convertDtoToModel(dto))
                .collect(Collectors.toSet());
    }
}
