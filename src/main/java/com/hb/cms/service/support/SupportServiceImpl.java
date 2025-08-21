package com.hb.cms.service.support;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hb.cms.dto.email.EmailDto;
import com.hb.cms.dao.support.SupportDao;

@Service
public class SupportServiceImpl implements SupportService {
	
	@Autowired
    private SupportDao dao;
	
	public int saveEmail(EmailDto emailDto) throws Exception{
	
		return dao.saveEmail(emailDto);
	}
}