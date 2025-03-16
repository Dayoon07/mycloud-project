package com.e.d.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Table(name = "MYCLOUD_FILES")
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FileEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "file_id", nullable = false)
	private long fileId;
	
	@Column(name = "file_user_id", nullable = false)
	private long fileUserId;
	
	@Column(name = "file_size", nullable = false)
	private double fileSize;
	
	@Lob
	@Column(name = "file_name", nullable = false)
	private String fileName;
	
	@Lob
	@Column(name = "file_location", nullable = false)
	private String fileLocation;
	
	@Column(name = "file_private", nullable = false)
	private String filePrivate;
	
	@Column(name = "create_at", nullable = false)
	private String createAt;
	
	@Column(name = "file_link", nullable = false)
	private String fileLink;
	
}
