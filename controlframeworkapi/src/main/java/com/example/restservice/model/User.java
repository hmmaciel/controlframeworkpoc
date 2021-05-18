package com.example.restservice.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class User {

    @Id
    @Column(unique=true)
    private String email;

    private String name;

    protected User() {}

    public User(String email, String name) {
        this.email = email;
        this.name = name;
    }

    public User(String email) {
        this.email = email;
        this.name = "";
    }

    public String getEmail() {
        return email;
    }

    public String getName() {
        return name;
    }
}
