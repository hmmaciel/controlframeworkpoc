package com.example.restservice.controllers;

import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import com.example.restservice.model.Question;
import com.example.restservice.model.Template;
import com.example.restservice.repositories.QuestionRepository;
import org.springframework.web.bind.annotation.*;

@RestController
public class QuestionController {

	private final QuestionRepository repository;

	public QuestionController(QuestionRepository repository) {
		this.repository = repository;
	}

	@GetMapping("/questions")
	public List<Question> getAll() {
		return (List<Question>) repository.findAll();
	}

	@GetMapping("/questions/{id}")
	public Question getQuestionById(@PathVariable Long id) {
		return repository.findById(id)
				.orElseThrow(() -> new RuntimeException("Could not find question " + id));
	}

	@PutMapping("/questions/{id}")
	public Question setQuestionAsChecked(@PathVariable Long id) {
		return repository.findById(id).map(
				question -> {
					question.addCheck();
					return repository.save(question);
				}
		).get();
	}
}
