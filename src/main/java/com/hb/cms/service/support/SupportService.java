package com.hb.cms.service.support;

import com.hb.cms.dto.email.EmailDto;

public interface SupportService {
	int saveEmail(EmailDto emailDto) throws Exception;
}