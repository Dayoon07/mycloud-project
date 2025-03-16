package com.e.d.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FileVo {
	private long fileId;
	private long fileUserId;
	private double fileSize;
	private String fileName;
	private String fileLocation;
	private String filePrivate;
	private String createAt;
	private String fileLink;
}
