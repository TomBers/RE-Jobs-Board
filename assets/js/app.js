// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import React from "react";
import ReactDOM from "react-dom";

class Hello extends React.Component {
    render () {
        return <p>{this.props.name}</p>
     }
}


class JobBlock extends React.Component {
 render() {
    const url = "http://localhost:4000/job/" + this.props.job.id
//    return <h1>{this.props.job.name} - {this.props.job.description}</h1>
    return  <div className="flex-item">
            {this.props.job.name} <br />
            {this.props.job.description} <br />
            <a href={url}>More</a>

            </div>
 }

}

class Jobs extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
        error: null,
        isLoaded: false,
        items: []
     };
  }
      componentDidMount() {
        fetch("http://localhost:4000/api/")
          .then(res => res.json())
          .then(
            (result) => {
                console.log(result);
              this.setState({
                isLoaded: true,
                items: result
              });
            },
            // Note: it's important to handle errors here
            // instead of a catch() block so that we don't swallow
            // exceptions from actual bugs in components.
            (error) => {
                console.log(error);
              this.setState({
                isLoaded: true,
                error
              });
            }
          )
      }
    render() {
        const { error, isLoaded, items } = this.state;
        if (error) {
          return <div>Error: {error.message}</div>;
        } else if (!isLoaded) {
          return <div>Loading...</div>;
        } else {
          return (
          <div className="flex-container">
              {items.map(job => (
                  <JobBlock job={job} key={job.name} />
              ))}
              </div>
          );
        }
      }
    }



var mountNode = document.getElementById("app");
ReactDOM.render(<Hello name="bob" />, mountNode);

function renderJobs() {
    ReactDOM.render(<Jobs />, mountNode);
}

window.renderJobs = renderJobs

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
