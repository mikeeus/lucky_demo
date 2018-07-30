import React from 'react';

import { ChatInput } from './ChatInput';
import { Message } from './Message';

export class Chat extends React.Component {
  state = {
    messages: []
  }

  componentDidMount = () => {
    if (this.props.messages) {
      this.setState({
        messages: this.props.messages
      })
    }
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
      <div style={{
        border: '1px solid grey',
        borderRadius: 3,
        margin: 'auto',
        maxWidth: '600px',
        padding: '15px',
      }}>
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
