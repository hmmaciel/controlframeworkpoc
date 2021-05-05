package com.example.restservice.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Question {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private long id;
    private String question;
    private String category;
    private boolean isChecked;

    protected Question() {}

    public Question(String question, String category) {
        this.id = id;
        this.question = question;
        this.category = category;
        this.isChecked = false;
    }

    public long getId() {
        return id;
    }

    public String getQuestion() {
        return question;
    }

    public boolean isChecked() { return isChecked; }

    public void addCheck() { this.isChecked = !isChecked; }
}
