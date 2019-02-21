import React from "react";

class JobBlock extends React.Component {
  isObject(obj) {
    return obj === Object(obj);
  }
  getMapValue(key) {
    return this.isObject(this.props.job[key]) ? this.props.job[key].value : this.props.job[key]
  }
 render() {
   const job = this.props.job
   const url = "http://localhost:4000/job/" + job.id + "/board/"+ this.props.boardId
   const objContext = this;
    return(
        <div className="flex-item">
            {Object.keys(job).map((key, index) => key !== "id" ? <div key={key}>{key} : {objContext.getMapValue(key)}</div> : null)}
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
              {items.map((job, indx) => <JobBlock job={job} boardId={this.props.boardId} key={indx} />)}
              </div>
          );
        }
      }
    }
