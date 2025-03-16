package com.e.d.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.e.d.model.dto.UserFileDto;

@Mapper
public interface FileMapper {
	Double selectMyDescSize(long id);
	List<UserFileDto> showDiffUserFile(String accessKey);
}
