import css from "../css/app.css"
import "phoenix_html"
import React from "react";
import ReactDOM from "react-dom";

import Jobs from "./jobs.js"
import Job from "./job.js"
import DateFilter from "./dateFilter.js"


var mountNode = document.getElementById("app");

function renderDateFilter(boardId) {
    var dateNode = document.getElementById("date");
    ReactDOM.render(<DateFilter boardId={boardId} />, dateNode);
}

function renderJobs(boardId, criteria, term) {
    ReactDOM.render(<Jobs boardId={boardId} criteria={criteria} term={term} />, mountNode);
}

function renderJob(id, boardId) {
    ReactDOM.render(<Job id={id} boardId={boardId} />, mountNode);
}

window.renderDateFilter = renderDateFilter
window.renderJobs = renderJobs
window.renderJob = renderJob

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
