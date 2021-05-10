import React from 'react';
import './Checklist.css';
import '../index.css';

class Checklist extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      error: null,
      questions: []
    };
  }

  componentDidMount() {
    fetch("/templates/" + this.props.location.state.email)
      .then(res => res.json())
      .then(
        (result) => {
          this.setState({
            questions: result.questions.map(entry => ({
              id: entry.id,
              description: entry.question,
              category: entry.category,
              checked: entry.checked,
            }))
          });
          //console.log(result.questions);
        },
        // Note: it's important to handle errors here
        // instead of a catch() block so that we don't swallow
        // exceptions from actual bugs in components.
        (error) => {
          this.setState({
            error
          });
        }
      )
  }

  toggleChecked(id) {
    const requestOptions = {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
    };
    fetch('/questions/' + id, requestOptions)
      .then(response => response.json());

      let questions = this.state.questions;

      questions.map(q => {
        if(q.id == id){
          q.checked = !q.checked;
        }
      })

      this.setState({questions: questions})
  }

  render() {
    let questionList = this.state.questions.map((entry) =>
      <li key={entry.id} className="todo stack-small">
        <div className="c-cb">
          <input type="checkbox" defaultChecked={entry.checked} onChange={() => this.toggleChecked(entry.id)} />
          <label className="todo-label">
            {entry.description}
          </label>
        </div>
      </li>
    )

    return (
      <div className="todoapp stack-large">
        <h1>Security Controls Framework</h1>
        <ul
          role="list"
          className="todo-list stack-large stack-exception"
          aria-labelledby="list-heading"
        >
          {questionList}
        </ul>
      </div>
    );
  }
}

export default Checklist;
