import React from 'react';
import ReactDOM from 'react-dom';

// Based on ReactRails' ReactUJS: https://github.com/reactjs/react-rails/blob/master/react_ujs/index.js

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
// import LuckyReactUJS from "./react_lucky_ujs";
// import { Component } from './components';
// LuckyReactUJS.register({ Component });
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
const LuckyReactUJS = {
  CLASS_NAME_ATTR: 'data-react-class',
  PROPS_ATTR: 'data-react-props',

  components: {},

  getNodes() {
    return document.querySelectorAll('[' + LuckyReactUJS.CLASS_NAME_ATTR + ']'); 
  },

  mountComponents() {
    const nodes = LuckyReactUJS.getNodes();
    
    for (let i = 0; i < nodes.length; ++i) {
      LuckyReactUJS.mountComponent(nodes[i]);
    }
  },

  mountComponent(node) {
    let className = node.getAttribute(LuckyReactUJS.CLASS_NAME_ATTR);
    let constructor = LuckyReactUJS.getConstructor(className);
    
    let propsJson = node.getAttribute(LuckyReactUJS.PROPS_ATTR);
    let props = propsJson && JSON.parse(propsJson);
  
    if (!constructor) {
      let message = "Cannot find component: '" + className + "'"
      if (console && console.log) {
        console.log("%c[react-lucky] %c" + message + " for element", "font-weight: bold", "", node)
      }
      throw new Error(message + ". Make sure you've registered your component, for example: LuckyReactUJS.register({ Component }).")
    } else {
      let children = LuckyReactUJS.nodeChildren(node);

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
    const nodes = LuckyReactUJS.getNodes();
  
    for (let i = 0; i < nodes.length; ++i) {
      ReactDOM.unmountComponentAtNode(nodes[i]);
    }
  },  

  setup() {
    document.addEventListener('turbolinks:load', LuckyReactUJS.mountComponents);
    document.addEventListener('turbolinks:before-render', LuckyReactUJS.unmountComponents);
  },
  
  teardown() {
    document.removeEventListener('turbolinks:load', LuckyReactUJS.mountComponents);
    document.removeEventListener('turbolinks:before-render',LuckyReactUJS.unmountComponents);
  },
  
  getConstructor(className) {
    // Try to access the class globally first then try eval
    return this.components[className] || window[className] || eval(className);
  },

  start() {
    // Remove then add event listeners
    LuckyReactUJS.teardown();
    LuckyReactUJS.setup();
  },

  register(componentHash) {
    Object.keys(componentHash).forEach(key => {
      this.components[key] = componentHash[key]
    });

    LuckyReactUJS.start();
  },
}

export default LuckyReactUJS;
