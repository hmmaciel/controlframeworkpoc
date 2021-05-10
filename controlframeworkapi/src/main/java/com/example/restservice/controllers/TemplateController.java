package com.example.restservice.controllers;

import java.util.List;

import com.example.restservice.model.Template;
import com.example.restservice.model.User;
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

    @GetMapping("/templates/{email}")
    public Template getTemplateByEmail(@PathVariable String email) {
        return repository.findByUser(new User(email));
    }
}
