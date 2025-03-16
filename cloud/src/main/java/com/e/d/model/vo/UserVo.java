package com.e.d.model.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserVo {
	private long userId;
	private String username;
	private String useremail;
	private String password;
	private String createAt;
	private String fileAccessKey;
}
