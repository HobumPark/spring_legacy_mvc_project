package com.hb.cms.controller;

import java.util.Locale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class ContentsController {
	
	@RequestMapping(value = "/contents/nasa", method = RequestMethod.GET)
	public String nasaPage(Locale locale, Model model) {
		
		return "/fun-contents/nasa-api-page";
	}
	
	@RequestMapping(value = "/contents/quotes", method = RequestMethod.GET)
	public String qoutesPage(Locale locale, Model model) {
		
		return "/fun-contents/quotes-api-page";
	}
	
	@RequestMapping(value = "/contents/weather", method = RequestMethod.GET)
	public String weatherPage(Locale locale, Model model) {
		
		return "/fun-contents/open-weather-api-page";
	}
	
	@RequestMapping(value = "/contents/useful-qr", method = RequestMethod.GET)
	public String usefuleQrPage(Locale locale, Model model) {
		
		return "/fun-contents/useful-qr-page";
	}
}
