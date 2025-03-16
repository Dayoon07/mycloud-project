package com.e.d.model.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.UserEntity;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {
	Optional<UserEntity> findByUsernameAndPassword(String username, String password);

	Optional<UserEntity> findByUsername(String username);

	Optional<UserEntity> findByUseremail(String useremail);

	Optional<UserEntity> findByFileAccessKey(String fileAccessKey);

	void deleteByUserId(long userId);
	
	long countByUserId(long userId);
}
