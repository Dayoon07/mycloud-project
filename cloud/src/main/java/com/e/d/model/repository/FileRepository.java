package com.e.d.model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.FileEntity;

@Repository
public interface FileRepository extends JpaRepository<FileEntity, Long> {
	List<FileEntity> findByFileUserIdOrderByCreateAtDesc(long fileUserId);

	Optional<FileEntity> findByFileLink(String fileLink);

	void deleteByFileUserId(long fileUserId);

	List<FileEntity> findByFileUserId(long fileUserId);
}
