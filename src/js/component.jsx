import React from 'react';

class Component extends React.Component {
  state = {
    query: '',
    items: [
      "Man in the High Castle",
      "The Expanse",
      "Silicon Valley",
      "Daredevil",
      "The Punisher",
      "Stranger Things",
    ],
    filtered: [],
    showList: false
  }

  handleInput = (event) => {
    const query = event.target.value;

    this.setState({
      filtered: this.state.items.filter(item =>
        item.toLowerCase().indexOf(query.toLowerCase()) !== -1,
      ),
      showList: this.shouldShowList()
    });
  }

  handleFocus = () => {
    this.setState({
      showList: this.shouldShowList()
    })
  }

  shouldShowList = () => {
    return this.state.filtered.length > 0;
  }

  handleBlur = () => {
    this.setState({
      showList: false
    })
  }

  render() {
    const list = <ul style={{
      margin: 0,
      listStyle: 'none',
      border: '1px solid',
      padding: '5px',
      boxSizing: 'border-box'}}>
      { this.state.filtered.map(item => <li key={item}>{item}</li>) }
    </ul>

    return (
      <div
        style={{width: 200, padding: '15px 15px 0'}}>
        <input
          onChange={this.handleInput}
          onFocus={this.handleFocus}
          onBlur={this.handleBlur}
          style={{width: '100%', boxSizing: 'border-box'}}
        />
        {this.state.showList ? list : null}          
      </div>
    )
  }
}

export default Component;