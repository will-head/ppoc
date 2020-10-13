# Podcast Player of Choice API backend

[![Build Status](https://travis-ci.com/will-head/ppoc.svg?branch=main)](https://travis-ci.com/will-head/ppoc)

## Overview

Podcast Player of Choice aims to simplify listening to podcasts in different players.

As podcasts are built on an open standard, many players exist. Subscribing to a new podcast in your podcast player of choice, however, isn't always straightforward. This project aims to make the process simpler.

This is the API backend, the front end can be found here: [github.com/will-head/podcast-player-of-choice](https://github.com/will-head/podcast-player-of-choice)

## Setup

```bash
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails s -p 3001
```

## Testing

To run RSpec (with coverage) followed by Rubocop run:  

```bash
$ rspec && rubocop
```

## Approach

The backend uses Rails and outputs JSON.  It's set to automatically deploy to [https://ppoc.dev/](https://ppoc.dev/) when continuous integration tests on [Travis](https://travis-ci.com/github/will-head/ppoc) pass.

## API

The API includes versioning in the url scheme. The current version is v1, accessible at:  
https://ppoc.dev/api/v1/

Any calls without versioning will redirect to the latest version:  
https://ppoc.dev/api/

The API version is included in the header, for example:  
version: V1

### Feeds

#### POST `/feeds`

Returns feeds

```bash
curl --request POST \
  --url https://ppoc.dev/api/v1/feeds \
  --header 'content-type: application/json' \
  --data '{
	"data": {
		"feed": "http://example.com/feed"
	}
}'
```

The following feed formats are accepted as input:

```
http://example.com/feed
https://example.com/feed
feed://example.com/feed
itpc://example.com/feed
podcast://example.com/feed
downcast://example.com/feed
pcast://example.com/feed

castro://subscribe/example.com/feed
pktc://subscribe/example.com/feed

overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed
```

On success, the above command returns JSON structured like this:
```json
{
  "request": {
    "feed": "http://example.com/feed"
  },
  "desktop": {
    "default": {
      "feed_title": "Default",
      "feed_url": "feed://example.com/feed"
    },
    "rss": {
      "feed_title": "RSS",
      "feed_url": "http://example.com/feed"
    },
    "itunes": {
      "feed_title": "iTunes",
      "feed_url": "itpc://example.com/feed"
    },
    "apple_podcasts": {
      "feed_title": "Apple Podcasts",
      "feed_url": "podcast://example.com/feed"
    }
  },
  "ios": {
    "default": {
      "feed_title": "Default",
      "feed_url": "feed://example.com/feed"
    },
    "apple_podcasts": {
      "feed_title": "Apple Podcasts",
      "feed_url": "podcast://example.com/feed"
    },
    "overcast": {
      "feed_title": "Overcast",
      "feed_url": "overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed"
    },
    "castro": {
      "feed_title": "Castro",
      "feed_url": "castro://subscribe/example.com/feed"
    },
    "pocket_casts": {
      "feed_title": "Pocket Casts",
      "feed_url": "pktc://subscribe/example.com/feed"
    },
    "downcast": {
      "feed_title": "Downcast",
      "feed_url": "downcast://example.com/feed"
    }
  },
  "android": {
    "default": {
      "feed_title": "Default",
      "feed_url": "pcast://example.com/feed"
    }
  }
}
```

## Improvements

* Return status in JSON body
* ~~Return 422 status and Error in JSON for invalid input feed~~
* ~~Remove redundant tests from FeedsController~~
* ~~Split FeedTransator into separate classes~~
* ~~Allow other feed formats as input - for example 'podcast://example.com/feed'~~
* Provide short link for feeds - for example ppoc.dev/x4ed6 -> https://podcastplayerofchoice.com/link/?url=http://example.com/feed
* Redirect root to API documentation page on [podcastplayerofchoice.com](https://podcastplayerofchoice.com/)
* ~~Validate feed url~~
* Add rate limiting
* Add CORS
* ~~Refactor add_prefix_to_feed to use sub/[]=~~ Faster to use split
