import React from 'react';
import ReactDOM from 'react-dom';

class Component extends React.Component {
  render() {
    return (
      <p>React component in Lucky!</p>
    )
  }
}

const tags = document.getElementsByTagName('component');

for (let i = 0; i < tags.length; i++) {
  ReactDOM.render(
  <Component />,
    tags[i]
  )
}