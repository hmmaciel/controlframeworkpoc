import React from "react";
import { Route, Switch } from "react-router-dom";
import Checklist from "./containers/Checklist";
import Login from "./containers/Login";

export default function Routes() {
  return (
    <Switch>
      <Route path="/checklist" render={(props) => <Checklist {...props}/>}/>
      <Route exact path="/">
        <Login />
      </Route>
    </Switch>
  );
}
