"use strict";

var tweetBot = require('TweetBot')

exports.handler = function(data, context) {
  // ignore the data input.
  console.log("inside handler");
  tweetBot.handler(context)();
};
