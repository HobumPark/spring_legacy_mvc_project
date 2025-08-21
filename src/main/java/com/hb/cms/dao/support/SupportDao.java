package com.hb.cms.dao.support;
import com.hb.cms.dto.email.EmailDto;

public interface SupportDao {
	int saveEmail(EmailDto emailDto) throws Exception;
}