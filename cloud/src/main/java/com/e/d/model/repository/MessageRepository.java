package com.e.d.model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.MessageEntity;

@Repository
public interface MessageRepository extends JpaRepository<MessageEntity, Long> {
	List<MessageEntity> findByReceiverIdOrderByDatetimeDesc(long receiveId);
	void deleteByReceiverId(long receiveId);
}
