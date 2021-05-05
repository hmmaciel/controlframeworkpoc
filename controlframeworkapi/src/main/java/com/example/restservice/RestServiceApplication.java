package com.example.restservice;

import com.example.restservice.model.Question;
import com.example.restservice.model.Template;
import com.example.restservice.repositories.QuestionRepository;
import com.example.restservice.repositories.TemplateRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.List;

@SpringBootApplication
public class RestServiceApplication {

    private static final Logger log = LoggerFactory.getLogger(RestServiceApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(RestServiceApplication.class, args);
    }

    @Bean
    public CommandLineRunner demo(QuestionRepository questions, TemplateRepository templates) {
        return (args) -> {
            // save a few questions
            questions.save(new Question("hello", "bla"));
            questions.save(new Question("hello2", "bla"));
            questions.save(new Question("hello3", "bla"));
            questions.save(new Question("hello4", "bla2"));

            templates.save(new Template((List<Question>) questions.findAll()));

        };
    }
}
