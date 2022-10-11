package com.kenya.bookclub.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kenya.bookclub.models.Book;
import com.kenya.bookclub.models.LoginUser;
import com.kenya.bookclub.models.User;
import com.kenya.bookclub.service.BookService;
import com.kenya.bookclub.service.UserService;

@Controller
public class HomeController {

	// Add once service is implemented:
	@Autowired
	private UserService userService;
	@Autowired
	private BookService bookServ;

	// ============== REGISTER =================
	@GetMapping("/")
	public String index(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "index.jsp";
	}

	// =============== Register Method ==============
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model,
			HttpSession session) {
		userService.register(newUser, result);
		if (result.hasErrors()) {
			// send in the empty LoginUser before re-rendering the page.
			model.addAttribute("newLogin", new LoginUser());
			return "index.jsp";
		} else {
			session.setAttribute("user_Id", newUser.getId());
			return "redirect:/dashboard";
		}
	}

	// =================== DASHBOARD ====================
	@GetMapping("/logged")
	public String dashboard(HttpSession s, Model model) {
		Long userId = (Long) s.getAttribute("user_Id");
		if (userId == null) {
			return "redirect:/home";
		} else {
			User user = userService.findOne(userId);
			model.addAttribute("user", user);
			return "redirect:/dashboard";
		}
	}

	// ================== LOGOUT ====================
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		// Set userId to null and redirect to login/register page
		session.setAttribute("user_Id", null);
		return "redirect:/";
	}

	// ================ LOGIN =========================
	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model,
			HttpSession session) {
		User user = userService.login(newLogin, result);
		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "index.jsp";
		}
		session.setAttribute("user_Id", user.getId());
		return "redirect:/dashboard";
	}
	// ================================ DASHBOARD ==================================

	// ========= Display all Books =================
	@GetMapping("/dashboard")
	public String index(Model model, HttpSession session) {

		Long userId = (Long) session.getAttribute("user_Id");
//		check if userId is signed in otherwise redirect
		if (userId == null) {
			return "redirect:/";
		} else {
			// bring in user
			User user = userService.findOne(userId);
			model.addAttribute("user", user);
			// bring in db info
			List<Book> alldabooks = bookServ.allBooks();
			model.addAttribute("allDaBooks", alldabooks);
			return "dashboard.jsp";
		}
	}

	// ========= Setup for Create Method =================
	@GetMapping("/create")
	public String allBooks(@ModelAttribute("books") Book book, Model model) {
		List<Book> allDaBooks = bookServ.allBooks();
		model.addAttribute("allDaBooks", allDaBooks);
		return "createBook.jsp";
	}

	// ========== Create a Book Entry =========
	@PostMapping("/newBook")
	public String createBook(@Valid @ModelAttribute("books") Book book, BindingResult result, Model model, 
			RedirectAttributes flash, HttpSession sesh) {
		if (result.hasErrors()) {
			List<Book> allBooks = bookServ.allBooks();
			model.addAttribute("allBooks", allBooks);
			return "createBook.jsp";
		} else {
			bookServ.createBook(book);
			return "redirect:/dashboard";
		}
	}

	// ===== SHOW ONE ENTRY ==============
	@GetMapping("/display/{id}")
	public String display(@PathVariable long id, Model model) {
		Book book = bookServ.findBook(id);
		model.addAttribute("book", book);
		return "display.jsp";
	}

	// ========== BRING UP EDIT PAGE ============================
	@GetMapping("/edit/{id}")
	public String edit(@PathVariable long id, Model model) {
		Book book = bookServ.findBook(id);
		model.addAttribute("book", book);
		return "editBook.jsp";
	}

	// =========== MAKE AN EDIT POST ===================
	@PutMapping("/edit/{id}")
	public String editPage(@Valid @ModelAttribute("book") Book book, BindingResult result) {
		if (result.hasErrors()) {
			return "editBook.jsp";
		} else {
			bookServ.updateBook(book);
			return "redirect:/dashboard";
		}
	}

	// ========= DELETE =========================
	@RequestMapping(value = "/book/{id}", method = RequestMethod.DELETE)
	public String remove(@PathVariable("id") Long id) {
		bookServ.deleteBook(id);
		return "redirect:/dashboard";
	}

}