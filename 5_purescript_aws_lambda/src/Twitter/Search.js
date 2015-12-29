/* global exports */
"use strict";

// module Twitter.Search

exports.search = function(client) {
  return function(searchOptions) {
    return function(callback) {
      return function() {
        client.get('search/tweets', searchOptions, function(error, tweets, response){
          var results = tweets.statuses.map(function(tweet) {
            return { id : tweet.id_str, user : tweet.user.screen_name, text : tweet.text };
          });
          callback(results)();
          return {};
        });
      };
    };
  };
};
