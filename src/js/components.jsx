import React from 'react';
import ReactDOM from 'react-dom';

// Components
import Component from './component';

const tags = document.getElementsByTagName('component')

console.log('tags: ', tags);

for (let i = 0; i < tags.length; i++) {
  ReactDOM.render(
  <Component />,
    tags[i]
  )
}
