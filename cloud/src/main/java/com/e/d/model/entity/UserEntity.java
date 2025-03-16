package com.e.d.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Table(name = "MYCLOUD_USERS")
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id", nullable = false)
	private long userId;
	
	@Column(name = "username", nullable = false, unique = true)
	private String username;
	
	@Column(name = "useremail", nullable = false, unique = true)
	private String useremail;
	
	@Column(name = "password", nullable = false)
	private String password;
	
	@Column(name = "create_at", nullable = false)
	private String createAt;
	
	@Column(name = "file_access_key", nullable = false)
	private String fileAccessKey;
	
}
