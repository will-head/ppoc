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

The backend uses Rails and outputs JSON.  It's set to automatically deploy to [https://ppoc.dev/](https://ppoc.dev/) when continuous integration tests on [Travis](https://travis-ci.com/) pass.

The API includes versioning in the url scheme. The current version is v1, accessible at:  
https://ppoc.dev/api/v1/

Any calls without versioning will redirect to the latest version:  
https://ppoc.dev/api/

## API

### Feeds

#### POST `/feeds`



## Improvements

* Redirect root to API documentation page on [podcastplayerofchoice.com](https://podcastplayerofchoice.com/)
* Validate feed url
* Refactor add_prefix_to_feed to use sub/[]=
