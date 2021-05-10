package com.example.restservice.controllers;

import com.example.restservice.model.User;
import com.example.restservice.repositories.UserRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UserController {

    private final UserRepository repository;

    public UserController(UserRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/users")
    public List<User> getAll() {
        return (List<User>) repository.findAll();
    }

    @GetMapping("/users/{email}")
    public User getUserById(@PathVariable String email) {
        return repository.findByEmail(email);
    }
}
