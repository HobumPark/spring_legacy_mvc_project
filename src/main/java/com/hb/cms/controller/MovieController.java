package com.hb.cms.controller;

import java.util.Locale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class MovieController {
	

	@RequestMapping(value = "/movie/movie-search", method = RequestMethod.GET)
	public String movieSearch(Locale locale, Model model) {
		
		return "/movie/movie-search";
	}
	
	@RequestMapping(value = "/movie/movie-detail", method = RequestMethod.GET)
	public String movieDetail(Locale locale, Model model) {
		
		return "/movie/movie-detail";
	}
	
	@RequestMapping(value = "/movie/movie-box-office", method = RequestMethod.GET)
	public String movieBoxOffice(Locale locale, Model model) {
		
		return "/movie/movie-box-office";
	}
	
	@RequestMapping(value = "/movie/movie-actor", method = RequestMethod.GET)
	public String movieActor(Locale locale, Model model) {
		
		return "/movie/movie-actor";
	}
	
	@RequestMapping(value = "/movie/movie-actor-detail", method = RequestMethod.GET)
	public String movieActorDetail(Locale locale, Model model) {
		
		return "/movie/movie-actor-detail";
	}
}
