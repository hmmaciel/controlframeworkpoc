package com.example.restservice.controllers;

import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import com.example.restservice.model.Question;
import com.example.restservice.model.Template;
import com.example.restservice.repositories.QuestionRepository;
import com.example.restservice.repositories.TemplateRepository;
import org.springframework.web.bind.annotation.*;

@RestController
public class TemplateController {

    private final TemplateRepository repository;

    public TemplateController(TemplateRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/templates")
    public List<Template> getAll() {
        return (List<Template>) repository.findAll();
    }

    @GetMapping("/templates/{id}")
    public Template getTemplateById(@PathVariable Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Could not find template " + id));
    }
}
