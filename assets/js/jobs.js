import React from "react";

class JobBlock extends React.Component {
 render() {
    const url = "http://localhost:4000/job/" + this.props.job.id + "/board/"+ this.props.boardId
    return(
        <div className="flex-item">
            {this.props.job.name} <br />
            {this.props.job.description} <br />
            {this.props.job.website} <br />
            <a href={url}>More</a>
        </div>
        )
    }
}

export default class Jobs extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
        error: null,
        isLoaded: false,
        items: []
     };
  }
      componentDidMount() {
        fetch("http://localhost:4000/api/board/" + this.props.boardId + "/" + this.props.criteria + '/' + this.props.term)
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
                  <JobBlock job={job} boardId={this.props.boardId} key={job.name} />
              ))}
              </div>
          );
        }
      }
    }
