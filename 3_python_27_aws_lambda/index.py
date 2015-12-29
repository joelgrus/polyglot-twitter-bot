from __future__ import print_function
from twython import Twython
from twython.exceptions import TwythonError
import json
import re

# credentials.json should look like
#
# {
#  "consumer_key": "...",
#  "consumer_secret": "...",
#  "access_token_key": "...",
#  "access_token_secret": "..."
# }
#
# or, if you're feeling dangerous, you can hardcode those values here
with open('credentials.json') as f:
    credentials = json.loads(f.read())

client = Twython(credentials["consumer_key"],
                  credentials["consumer_secret"],
                  credentials["access_token_key"],
                  credentials["access_token_secret"])

rgx = r"make (.*) great again"
query = 'make "great again" -america -filter:retweets'

def handler(event, context):
    results = client.search(q=query)
    print("found", len(results["statuses"]), "tweets")
    for tweet in results["statuses"]:
        text = tweet["text"]
        if re.search(rgx, text, re.I):
            print(tweet["text"])
            # twitter.retweet will raise an error if we try to retweet a tweet
            # that we've already retweeted. to avoid having to keep track, we
            # just use a try/except block
            try:
                client.retweet(id=tweet["id"])
            except TwythonError as e:
                print(e)
