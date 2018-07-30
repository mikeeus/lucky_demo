import React from 'react';

export class ChatInput extends React.Component {
  handleKeyPress = (e) => {
    if (e.charCode === 13) {
      this.props.writeMessage(e.target.value)
    }
  }

  render() {
    return (
      <input
        style={{
          boxSizing: 'border-box',
          margin: 'auto',
          marginLeft: '10%',
          marginTop: '15px',
          width: '80%',
        }}
        placeholder="Say something nice..."
        onKeyPress={this.handleKeyPress} />
    )
  }
}
