package ro.ubb.catalog.core.repository;

import ro.ubb.catalog.core.model.Message;

/**
 * Created by hd on 28-May-17.
 */
public interface MessageRepository  extends org.springframework.data.jpa.repository.JpaRepository<Message, Long> {

}
