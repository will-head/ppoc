class FeedFormatter

  def initialize(translated_feed)
    @translated_feed = translated_feed
  end

  def body
    {
      request: { feed: @translated_feed.request },
      desktop: desktop,
      ios: nil,
      android: nil
    }
  end

  def desktop
    { 
      default: { feed_title: "Default", feed_url: @translated_feed.feed },
      rss: nil,
      itunes: nil,
      apple_podcasts: nil
    }
  end
end
