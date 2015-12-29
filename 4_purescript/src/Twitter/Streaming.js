/* global exports */
"use strict";

// module Twitter.Streaming

exports.streamImpl = function(client, streamOptions, onData, onError) {
  return function() {
    client.stream('statuses/filter', streamOptions, function(stream) {
      stream.on('data', function(tweet) {
        console.log(tweet.text);
        onData(tweet);
      });
      stream.on('error', onError);
    });
  };
};
