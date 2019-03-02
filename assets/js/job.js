import React from "react";
import ReactQuill from 'react-quill';


class Link extends React.Component {
    render() {
        const tag = this.props.value
        return (<span><a href={`http://localhost:4000/board/${this.props.board}/${this.props.category}/${tag}`}>{this.props.text}</a> </span>)
    }
}


class JobPosting extends React.Component {
  isObject(obj) {
    return obj === Object(obj);
  }
  getMapValue(key) {
    return this.isObject(this.props.job[key]) ? this.props.job[key].value : this.props.job[key]
  }
 render() {
   const job = this.props.job
    const tags = this.props.job.hasOwnProperty('tags') ? this.props.job.tags.map((tag) => <Link value={tag} category={"tags"} text={tag} board={this.props.board} key={tag}/>) : [];
    const owner = this.props.job.hasOwnProperty('owner') ? <Link value={this.props.job.owner.name} category={"owner"} text={this.props.job.owner.name} board={this.props.board} /> : [];    
    const objContext = this;
    return  (
        <div className="flex-item">
            {Object.keys(job).map((key, index) => key !== "id" ? <div key={key}>{key} : {objContext.getMapValue(key)}</div> : null)}
            <ReactQuill value={this.props.job.ops} theme={null} readOnly={true} /><br />
            {owner}
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
        fetch("http://localhost:4000/api/job/" + this.props.id + "/board/" + this.props.boardId)
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
             <JobPosting job={job} board={this.props.boardId} key={job.id} />
          </div>
          );
        }
      }
    }
