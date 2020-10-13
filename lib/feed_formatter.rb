class FeedFormatter

  def initialize(translated_feed)
    @translated_feed = translated_feed
  end

  def body
    {
      request: { feed: @translated_feed.request },
      desktop: { default: nil, rss: nil, itunes: nil, apple_podcasts: nil },
      ios: nil,
      android: nil
    }
  end

end
