import React from 'react';
import ReactDOM from 'react-dom';

// Based on ReactRails' React: https://github.com/reactjs/react-rails/blob/master/react_ujs/index.js

// Add event listeners to find all elements with [data-react-class] attribute,
// get the react class name from the attribute and render the component using
// ReactDOM.
// Props can be passed in using the [data-react-props] attribute as a 
// stringified json object.
// 
// Usage
// 
// ```javascript
// // src/js/app.js
// import LuckyReact from "./react_lucky";
// import { Component } from './components';
// LuckyReact.register({ Component });
// ```
// 
// And in your Lucky Page.
// 
// ```crystal
// class Home::IndexPage < GuestLayout
//   def content
//     h1 "React Component"
//     div "data-react-class": "Component",
//         "data-react-props": { message: "Message" }.to_json
//   end
// end
// ```
// 
const LuckyReact = {
  CLASS_NAME_ATTR: 'data-react-class',
  PROPS_ATTR: 'data-react-props',

  components: {},

  getNodes() {
    return document.querySelectorAll('[' + LuckyReact.CLASS_NAME_ATTR + ']'); 
  },

  mountComponents() {
    const nodes = LuckyReact.getNodes();
    
    for (let i = 0; i < nodes.length; ++i) {
      LuckyReact.mountComponent(nodes[i]);
    }
  },

  mountComponent(node) {
    let className = node.getAttribute(LuckyReact.CLASS_NAME_ATTR);
    let constructor = LuckyReact.getConstructor(className);
    
    let propsJson = node.getAttribute(LuckyReact.PROPS_ATTR);
    let props = propsJson && JSON.parse(propsJson);
  
    if (!constructor) {
      let message = "Cannot find component: '" + className + "'"
      if (console && console.log) {
        console.log("%c[react-lucky] %c" + message + " for element", "font-weight: bold", "", node)
      }
      throw new Error(message + ". Make sure you've registered your component, for example: LuckyReact.register({ Component }).")
    } else {
      let children = LuckyReact.nodeChildren(node);

      ReactDOM.render(
        React.createElement(constructor, { ...props, children }),
        node
      );
    }
  },

  nodeChildren(node) {
    if (node.childNodes.length > 0) {
      return <div dangerouslySetInnerHTML={{ __html: node.innerHTML }} />
    } else {
      return null;
    }
  },

  unmountComponents() {
    const nodes = LuckyReact.getNodes();
  
    for (let i = 0; i < nodes.length; ++i) {
      ReactDOM.unmountComponentAtNode(nodes[i]);
    }
  },  

  setup() {
    document.addEventListener('turbolinks:load', LuckyReact.mountComponents);
    document.addEventListener('turbolinks:before-render', LuckyReact.unmountComponents);
  },
  
  teardown() {
    document.removeEventListener('turbolinks:load', LuckyReact.mountComponents);
    document.removeEventListener('turbolinks:before-render',LuckyReact.unmountComponents);
  },
  
  getConstructor(className) {
    // Try to access the class globally first then try eval
    return this.components[className] || window[className] || eval(className);
  },

  start() {
    // Remove then add event listeners
    LuckyReact.teardown();
    LuckyReact.setup();
  },

  register(componentHash) {
    Object.keys(componentHash).forEach(key => {
      this.components[key] = componentHash[key]
    });

    LuckyReact.start();
  },
}

export default LuckyReact;
