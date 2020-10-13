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
      rss: { feed_title: "RSS", feed_url: @translated_feed.http },
      itunes: { feed_title: "iTunes", feed_url: @translated_feed.itpc },
      apple_podcasts: nil
    }
  end
end
