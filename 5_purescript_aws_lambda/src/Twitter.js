/* global exports */
"use strict";

// module Twitter

var Twitter = require('twitter');

exports.twitterClient = function(credentials) {
  return function() {
    return new Twitter(credentials);
  };
};
