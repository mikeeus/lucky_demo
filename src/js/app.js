/* eslint no-console:0 */

// RailsUjs is *required* for links in Lucky that use DELETE, POST and PUT.
import RailsUjs from "rails-ujs";

// Turbolinks is optional. Learn more: https://github.com/turbolinks/turbolinks/
import Turbolinks from "turbolinks";

// LuckyReactUJS is for adding react components.
import LuckyReact from "lucky-react";

// First import React components
import { Chat, Bordered } from './components';

RailsUjs.start();
Turbolinks.start();

LuckyReact.register({ Chat, Bordered });