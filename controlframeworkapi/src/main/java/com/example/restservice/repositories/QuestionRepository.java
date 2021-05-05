package com.example.restservice.repositories;


import com.example.restservice.model.Question;
import org.springframework.data.repository.CrudRepository;

public interface QuestionRepository extends CrudRepository<Question, Long> {

    Question findById(long id);
}
