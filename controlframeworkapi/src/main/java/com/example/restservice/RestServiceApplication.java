package com.example.restservice;

import com.example.restservice.model.Question;
import com.example.restservice.model.Template;
import com.example.restservice.model.User;
import com.example.restservice.repositories.QuestionRepository;
import com.example.restservice.repositories.TemplateRepository;
import com.example.restservice.repositories.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.ArrayList;
import java.util.List;

@SpringBootApplication
public class RestServiceApplication {

    private static final Logger log = LoggerFactory.getLogger(RestServiceApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(RestServiceApplication.class, args);
    }

    @Configuration
    @EnableWebMvc
    public class WebConfig implements WebMvcConfigurer {
        @Override
        public void addCorsMappings(CorsRegistry registry) {
            registry.addMapping("/**").allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS");
        }
    }

    @Bean
    public CommandLineRunner demo(QuestionRepository questions, TemplateRepository templates, UserRepository users) {
        return (args) -> {
            // save a few questions
            Question q1 = new Question("hello", "bla");
            Question q2 = new Question("hello2", "bla");
            Question q3 = new Question("hello3", "bla2");
            Question q4 = new Question("hello4", "bla2");
            Question q5 = new Question("hello5", "bla3");

            questions.save(q1);
            questions.save(q2);
            questions.save(q3);
            questions.save(q4);
            questions.save(q5);

            // save a few users
            User john = new User("john@mail.com", "John");
            User doe = new User("doe@mail.com", "Doe");

            users.save(john);
            users.save(doe);

            // save a few templates
            List<Question> questionList = new ArrayList();
            questionList.add(q1);
            questionList.add(q2);
            questionList.add(q3);

            Template t1 = new Template(questionList, john);

            templates.save(t1);

            questionList.clear();

            questionList.add(q4);
            questionList.add(q5);

            Template t2 = new Template(questionList, doe);

            templates.save(t2);

        };
    }
}
