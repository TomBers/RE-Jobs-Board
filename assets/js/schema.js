import React from "react";

export default class Schema extends React.Component {
  constructor(props) {
      super(props);
      this.state = {elements: props.data};
    }
  addEle() {
    var field = prompt("Please enter field name:");
    let ele = this.state.elements
    ele[field] = {value:"", type: "TEXT", options: []}
    this.setState({
      elements: ele
    });
  }
  updateOption(fieldName, type, option) {
    let ele = this.state.elements
    let opts = ele[fieldName].options
    opts.push(option)
    ele[fieldName] = {value:"", type: type, options: opts}
    console.log(ele)
    this.setState({
      elements: ele
    });
  }
  updateType(fieldName, type) {
    let ele = this.state.elements
    let old = ele[fieldName]
    ele[fieldName] = {value: old.value, type: type, options: old.options }
    this.setState({
      elements: ele
    });
  }
  saveSchema() {
    const url = `http://localhost:4000/api/board/${this.props.boardId}/schema/update`

    this.props.sendToServer(url, JSON.stringify({fields: this.state.elements}))
  }
  render() {
    return <div>
      {Object.keys(this.state.elements).map((key, index) => <RenderElement fieldName={key} value={this.state.elements[key]} updateOption={(a, b, c) => this.updateOption(a,b,c)} updateType={(a, b) => this.updateType(a,b)} key={key} />)}
      <br /><br />
      <a href="#" className="btn btn-primary" onClick={(e) => {e.preventDefault; this.addEle()} }>
      Add field
    </a>
    <br /><br />
    <a href="#" className="btn indigo darken-2" onClick={(e) => {e.preventDefault; this.saveSchema()} }>
    Save Schema
  </a>
      </div>
  }
}

class RenderElement extends React.Component {
  addOption(fieldName, type) {
    var field = prompt("Please enter option");
    this.props.updateOption(fieldName, type, field);
  }
  changeSelect(e) {
    this.props.updateType(this.props.fieldName, e.target.value)
  }
  render() {
    const {fieldName, value} = this.props
    return (<div>
        <input defaultValue={fieldName} />
        <select name="single_choice" className="browser-default" defaultValue={value.type} onChange={this.changeSelect.bind(this)}><option value="TEXT">Text</option><option value="OPTION">Single Choice</option><option value="MULTIPLECHOICE">MULTIPLE CHOICE</option></select>
        {value.options.map((v) => <div key={v}>{v}</div>)}
        <a href="#" className="btn cyan lighten-2" onClick={(e) => {e.preventDefault; this.addOption(fieldName, value.type)} }>Add option</a>
      </div>)
  }
}
