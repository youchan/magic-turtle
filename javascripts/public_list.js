// entry file for the browser environment
// import stylesheets here
import '../styles/application.scss';

// import npm modules that are valid to use only in the browser
// for example modules which depend on the window or document objects of the browser
//
// example:
//
// import ReactDOM from 'react-dom';
// global.ReactDOM = ReactDOM;

// import modules common to browser and server side rendering (ssr)
// environments from application_common.js
import './application_common.js';

// import and load opal ruby files
import init_app from 'public_list.rb';
init_app();
Opal.load('public_list');

// allow for hot reloading
if (module.hot) { module.hot.accept(); }


