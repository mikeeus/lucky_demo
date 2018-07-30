import React from 'react';

export class Bordered extends React.Component {  
  render() {
    return (
      <div style={{border: '2px solid'}}>
        {this.props.children}
      </div>
    )
  }
}
