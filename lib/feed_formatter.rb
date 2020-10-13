class FeedFormatter

  def initialize(translated_feed)
    @translated_feed = translated_feed
  end

  def body
    {
      status: status_key_value,
      request: request_key_value,
      desktop: desktop_key_value,
      ios: ios_key_value,
      android: android_key_value
    }
  end

  private

  def status_key_value
    200
  end

  def request_key_value
    {
      feed: @translated_feed.request
    }
  end

  def desktop_key_value
    { 
      default: { feed_title: "Default", feed_url: @translated_feed.feed },
      rss: { feed_title: "RSS", feed_url: @translated_feed.http },
      itunes: { feed_title: "iTunes", feed_url: @translated_feed.itpc },
      apple_podcasts: { feed_title: "Apple Podcasts", feed_url: @translated_feed.podcast }
    }
  end

  def ios_key_value
    {
      default: { feed_title: "Default", feed_url: @translated_feed.feed },
      apple_podcasts: { feed_title: "Apple Podcasts", feed_url: @translated_feed.podcast },
      overcast: { feed_title: "Overcast", feed_url: @translated_feed.overcast },
      castro: { feed_title: "Castro", feed_url: @translated_feed.castro },
      pocket_casts: { feed_title: "Pocket Casts", feed_url: @translated_feed.pktc },
      downcast: { feed_title: "Downcast", feed_url: @translated_feed.downcast }
    }
  end

  def android_key_value
    {
      default: { feed_title: "Default", feed_url: @translated_feed.pcast }
    }
  end
end
