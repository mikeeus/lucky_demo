/* eslint no-console:0 */

// RailsUjs is *required* for links in Lucky that use DELETE, POST and PUT.
import RailsUjs from "rails-ujs";

// Turbolinks is optional. Learn more: https://github.com/turbolinks/turbolinks/
import Turbolinks from "turbolinks";

// LuckyReactUJS is for adding react components.
import LuckyReactUJS from "./lucky_react_ujs";

// First import React components
import { Chat, Wrapper } from './components';

RailsUjs.start();
Turbolinks.start();

LuckyReactUJS.register({ Chat, Wrapper });
