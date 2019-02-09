import React from "react";

class JobPosting extends React.Component {
 render() {
    const tags = this.props.job.tags.join(",");
    const d = new Date(this.props.job.posted);
    return  (
        <div className="flex-item">
            <strong>Title: {this.props.job.name}</strong> <br />
            Description: {this.props.job.description} <br />
            Tags: {tags} <br />
            Posted: {d.toString()}
        </div>
        )
    }
}

export default class Job extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
        error: null,
        isLoaded: false,
        job: null
     };
  }
      componentDidMount() {
        fetch("http://localhost:4000/api/board/" + this.props.boardId + "/job/" + this.props.id)
          .then(res => res.json())
          .then(
            (result) => {
                console.log(result);
              this.setState({
                isLoaded: true,
                job: result
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
        const { error, isLoaded, job } = this.state;
        if (error) {
          return <div>Error: {error.message}</div>;
        } else if (!isLoaded) {
          return <div>Loading...</div>;
        } else {
          return (
          <div className="flex-container">
             <JobPosting job={job} key={job.name} />
          </div>
          );
        }
      }
    }