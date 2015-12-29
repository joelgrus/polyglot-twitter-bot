/* global exports */
"use strict";

// module Twitter.Search

exports.searchImpl = function(client, searchOptions, callback) {
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
