import React from 'react';

export class Message extends React.Component {
  get flexDirection() {
    return this.props.sender === "me" ? "row" : "row-reverse";
  }

  get image() {
    return this.props.sender === "me" ? "/assets/images/mikias.jpeg" : "/assets/images/chatbot.png";
  }

  get senderStyle() {
    return {
      backgroundImage: "url(" + this.image +")",
      backgroundSize: 'cover',
      backgroundRepeat: 'no-repeat',
      backgroundPosition: 'center center',
      border: '1px solid',
      borderRadius: '50%',
      margin: '0 15px',
      height: '35px',
      width: '35px',
    }
  }

  render() {
    return (
      <div style={{
        display: 'flex',
        flexDirection: this.flexDirection,
        padding: '10px',
        borderRadius: 3}}>
        <div style={this.senderStyle}></div>
        <div style={{
            alignItems: 'center',
            display: 'flex',
            justifyContent: 'space-between',
            width: '100%',
            margin: '0 15px',  
          }}>
          <strong>{this.props.text}</strong>
          <small>{new Date().toLocaleTimeString()}</small>
        </div>
      </div>
    )
  }
}
