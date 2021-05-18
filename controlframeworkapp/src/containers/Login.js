import React, { useState } from "react";
import Form from "react-bootstrap/Form";
import Button from "react-bootstrap/Button";

import { useHistory } from "react-router-dom";

export default function Login() {
    const [email, setEmail] = useState("");

    const history = useHistory();

    function validateForm() {
        return email.length > 0;
    }

    function handleSubmit(event) {
        event.preventDefault();

        history.push({
            pathname: '/checklist',
            state: {  // location state
                email: email,
            },
        });
    }

    return (
        <div className="Login">
            <Form onSubmit={handleSubmit}>
                <Form.Group size="lg" controlId="email">
                    <Form.Label>Email</Form.Label>
                    <Form.Control
                        autoFocus
                        type="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                    />
                </Form.Group>
                <Button block size="lg" type="submit" disabled={!validateForm()}>
                    Login
        </Button>
            </Form>
        </div>
    );
}