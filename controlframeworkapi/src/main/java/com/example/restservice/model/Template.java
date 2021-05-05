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

    protected Template() {}

    public Template(List<Question> questions) {
        this.id = id;
        this.questions = questions;
    }

    public long getId() {
        return id;
    }

    public List<Question> getQuestions() {
        return questions;
    }
}
