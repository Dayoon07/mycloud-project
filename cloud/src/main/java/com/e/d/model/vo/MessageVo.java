package com.e.d.model.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MessageVo {
	private long msgId;
	private String sender;
	private String receiver;
	private long receiverId;
	private String title;
	private String content;
	private String datetime;
	private String contentFile;
}
