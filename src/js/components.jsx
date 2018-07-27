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
        <div style={messageContentStyle}>
          <strong>{this.props.text}</strong>
          <small>{new Date().toLocaleTimeString()}</small>
        </div>
      </div>
    )
  }
}

export class Chat extends React.Component {
  state = {
    messages: []
  }

  componentDidMount = () => {
    this.setState({
      messages: this.props.messages
    })
  }
  
  getNewId = () => {
    const last = this.state.messages[this.state.messages.length - 1];
    return last && last.id + 1;
  }

  onWriteMessage = (text) => {
    const message = {
      id: this.getNewId() || 1,
      text,
      sender: "me"
    }

    this.setState({
      messages: [...this.state.messages, message, this.autoResponse()]
    })
  }

  autoResponse = () => {
    return {
      id: this.getNewId() + 1,
      text: "Sorry I'm away at lunch. Be back soon :).",
      sender: "chatbot"
    }
  }

  render() {
    return (
      <div style={chatStyle}>
        <h2 style={{textAlign: 'center'}}>Conversation</h2>
        <div>
          {
            this.state.messages.map(message => 
              <Message
                key={message.id}
                sender={message.sender}
                text={message.text} />
            )
          }
        </div>
        <ChatInput writeMessage={this.onWriteMessage}/>
      </div>
    )
  }
}

export class ChatInput extends React.Component {
  handleKeyPress = (e) => {
    if (e.charCode === 13) {
      this.props.writeMessage(e.target.value)
    }
  }

  render() {
    return (
      <input
        style={inputStyle}
        placeholder="Say something nice..."
        onKeyPress={this.handleKeyPress} />
    )
  }
}

// Styles
const messageContentStyle = {
  alignItems: 'center',
  display: 'flex',
  justifyContent: 'space-between',
  width: '100%',
  margin: '0 15px',  
}

const chatStyle = {
  border: '1px solid grey',
  borderRadius: 3,
  margin: 'auto',
  maxWidth: '600px',
  padding: '15px',
}

const inputStyle = {
  boxSizing: 'border-box',
  margin: 'auto',
  marginLeft: '10%',
  marginTop: '15px',
  width: '80%',
}