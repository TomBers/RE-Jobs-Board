import css from "../css/app.css"
import "phoenix_html"
import React from "react";
import ReactDOM from "react-dom";

import Jobs from "./jobs.js"
import Job from "./job.js"


var mountNode = document.getElementById("app");

function renderJobs(boardId) {
    ReactDOM.render(<Jobs boardId={boardId} />, mountNode);
}

function renderJob(id, boardId) {
    ReactDOM.render(<Job id={id} boardId={boardId} />, mountNode);
}

window.renderJobs = renderJobs
window.renderJob = renderJob

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
