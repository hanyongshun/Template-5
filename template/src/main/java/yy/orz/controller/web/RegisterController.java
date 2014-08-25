/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package yy.orz.controller.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 用户注册的Controller.
 * 
 * @author calvin
 */
@Controller
@RequestMapping(value = "/register")
public class RegisterController {

//	@Autowired
//	private AccountService accountService;
//
//	@RequestMapping(method = RequestMethod.GET)
//	public String registerForm() {
//		return "account/register";
//	}
//
//	@RequestMapping(method = RequestMethod.POST)
//	public String register(@Valid User user, RedirectAttributes redirectAttributes) {
//		accountService.registerUser(user);
//		redirectAttributes.addFlashAttribute("username", user.getLoginName());
//		return "redirect:/login";
//	}
//
//	/**
//	 * Ajax请求校验loginName是否唯一。
//	 */
//	@RequestMapping(value = "checkLoginName")
//	@ResponseBody
//	public String checkLoginName(@RequestParam("loginName") String loginName) {
//		if (accountService.findUserByLoginName(loginName) == null) {
//			return "true";
//		} else {
//			return "false";
//		}
//	}
}
