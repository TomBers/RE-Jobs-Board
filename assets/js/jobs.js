import React from "react";


class Link extends React.Component {
    render() {
        return (<span><a href={`http://localhost:4000/board/${this.props.board}/${this.props.category}/${this.props.tag}`}>{this.props.text}</a> </span>)
    }
}

class RenderLinks extends React.Component {
  render() {
    const {tag, value, boardId} = this.props
    const processedVals = Array.isArray(value) ? value : [value]
    let comps = []
    processedVals.forEach((val) => comps.push(<Link board={boardId} category={tag} tag={val} text={val} key={val} />))
    return (
      <div>
      {tag} :: {comps}
      </div>
    )
  }
}


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
   const editUrl = "http://localhost:4000/board/" + this.props.boardId + "/job/" + job.id + "/edit"
   const objContext = this;
    return(
        <div className="flex-item">
            {/* Object.keys(job).map((key, index) => key !== "id" ? <div key={key}>{key} : {objContext.getMapValue(key)}</div> : null) */}
            {Object.keys(job).map((key, index) => (key !== "id" && key !== "posted") ? <RenderLinks tag={key} value={objContext.getMapValue(key)} boardId={this.props.boardId} key={key} /> : null)}
            <a href={editUrl} target="_blank">Edit Job</a>
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
        fetch("http://localhost:4000/api/board/" + this.props.boardId + "/search", {
              method: "POST",
              mode: "cors",
              cache: "no-cache",
              credentials: "same-origin",
              headers: {
                  "Content-Type": "application/json",
              },
              redirect: "follow",
              referrer: "no-referrer",
              body: this.props.filters,
          })
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
