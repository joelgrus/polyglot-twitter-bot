var Twitter = require('twitter');
var credentials = require('./credentials');

var client = new Twitter(credentials);

var query = 'make "great again" -america -filter:retweets';
var rgx = /make .* great again/i;

// Runs a Twitter search for the specified `query` and retweets all the results.
function searchAndTweet(succeed, fail) {
  console.log("search and tweet");
  client.get('search/tweets', {q: query, count: 15}, function(err, tweets, response) {
    if (!tweets.statuses) {
      fail(err);
    }

    console.log(new Date());
    console.log('found ' + tweets.statuses.length + ' tweets');

    tweets.statuses.forEach(function(tweet) {
      // Make sure we match the regex.
      var match = tweet.text.match(rgx);
      if (match) {
        var tweetId = tweet.id_str;
        client.post('statuses/retweet/' + tweetId, function(err, tweet, id) {
          // Will return an error if we try to retweet a tweet that we've already
          // retweeted.
          console.log(err || tweet.text);
        });
      } else {
        // consider doing something for no match
      }
    });
    succeed("success");
  });
}

setTimeout(function() {
  searchAndTweet(console.log, console.log);
}, 5 * 60 * 1000);
