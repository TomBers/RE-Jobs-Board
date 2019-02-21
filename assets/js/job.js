import React from "react";
import ReactQuill from 'react-quill';


class Link extends React.Component {
    render() {
        const tag = this.props.value
        return (<span><a href={`http://localhost:4000/board/${this.props.board}/${this.props.category}/${tag}`}>{this.props.text}</a> </span>)
    }
}


class JobPosting extends React.Component {
 render() {
    const tags = this.props.job.hasOwnProperty('tags') ? this.props.job.tags.map((tag) => <Link value={tag} category={"tags"} text={tag} board={this.props.board} key={tag}/>) : [];
    const owner = this.props.job.hasOwnProperty('owner') ? <Link value={this.props.job.owner.name} category={"owner"} text={this.props.job.owner.name} board={this.props.board} /> : [];
    const d = new Date(this.props.job.posted);
    return  (
        <div className="flex-item">
            <strong>Title: {this.props.job.name}</strong> <br />
            Description: {this.props.job.description} <br />
            Tags: {tags} <br />
            Posted: {d.toString()} <br />
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
             <JobPosting job={job} board={this.props.boardId} key={job.name} />
          </div>
          );
        }
      }
    }
