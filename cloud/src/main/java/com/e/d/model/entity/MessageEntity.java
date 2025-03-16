package com.e.d.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Table(name = "MYCLOUD_MESSAGE")
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MessageEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "msg_id", nullable = false)
	private long msgId;
	
	@Column(name = "sender", nullable = false)
	private String sender;
	
	@Column(name = "receiver", nullable = false)
	private String receiver;
	
	@Column(name = "receive_id", nullable = false)
	private long receiveId;
	
	@Column(name = "title", nullable = false)
	private String title;
	
	@Lob
	@Column(name = "content")
	private String content;
	
	@Column(name = "datetime", nullable = false)
	private String datetime;
	
	@Lob
	@Column(name = "content_file")
	private String contentFile;
	
}
