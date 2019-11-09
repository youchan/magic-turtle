// entry file for browser webworkers
// import npm modules that are only valid to use within browser webworkers
// import ...;

// import and load opal ruby files
import init_webworker from 'opal_webworker_loader.rb';
init_webworker();
Opal.load('opal_webworker_loader');

// allow for hot reloading
if (module.hot) { module.hot.accept(); }
