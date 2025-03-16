package com.e.d.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.e.d.model.vo.UserVo;

@Mapper
public interface UserMapper {
	List<UserVo> findRecipient(String email);
}
