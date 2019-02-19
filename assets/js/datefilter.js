import React from "react";

function getPastDate(days) {
    let today = new Date()
    let pastDate = today.getDate() - days
    today.setDate(pastDate)
    return today.toISOString()
}

export default class DateFilter extends React.Component {
    render() {
        return (
        <div>
            <RenderLinks board={this.props.boardId} category={"posted"} value={getPastDate(7)} text={"Last week"} />
            <RenderLinks board={this.props.boardId} category={"posted"} value={getPastDate(14)} text={"Last 2 weeks"} />
            <RenderLinks board={this.props.boardId} category={"posted"} value={getPastDate(31)} text={"Last month"} />
         </div>)
    }
}

class RenderLinks extends React.Component {
    render() {
        const tag = this.props.value
        return (<span><a href={`http://localhost:4000/board/${this.props.board}/${this.props.category}/${tag}`}>{this.props.text}</a> </span>)
    }
}

