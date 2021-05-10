package com.example.restservice.model;

import javax.persistence.*;
import java.util.List;

@Entity
public class Template {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private long id;
    @OneToMany
    private List<Question> questions;
    @OneToOne
    private User user;

    protected Template() {}

    public Template(List<Question> questions, User user) {
        this.id = id;
        this.questions = questions;
        this.user = user;
    }

    public long getId() {
        return id;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public String getEmail() {
        return user.getEmail();
    }
}
