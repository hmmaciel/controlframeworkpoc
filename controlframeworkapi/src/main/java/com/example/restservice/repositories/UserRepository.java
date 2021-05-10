package com.example.restservice.repositories;

import com.example.restservice.model.User;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, String> {

    User findByEmail(String email);
}
