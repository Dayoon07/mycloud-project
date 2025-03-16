package com.e.d.model.dto;

import com.e.d.model.vo.FileVo;
import com.e.d.model.vo.UserVo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserFileDto {
	private UserVo userVo;
	private FileVo fileVo;
}
