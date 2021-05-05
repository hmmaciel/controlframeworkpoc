package com.example.restservice.repositories;

import com.example.restservice.model.Template;
import org.springframework.data.repository.CrudRepository;

public interface TemplateRepository extends CrudRepository<Template, Long> {

    Template findById(long id);
}
