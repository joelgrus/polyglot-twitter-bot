/* global exports */
"use strict";

// module Twitter.Retweet

exports.retweetImpl = function(client, tweetId) {
  return function() {
    client.post('statuses/retweet/' + tweetId, function(err, tweet, id) {
              console.log(err || tweet.text);
    });
  };
};
