class FeedFormatter

  def initialize(translated_feed)
    @translated_feed = translated_feed
  end

  def body
    return invalid_request_body unless @translated_feed.valid_request?

    valid_request_body
  end

  private

  def valid_request_body
    {
      status: 200,
      request: request_key_value,
      desktop: desktop_key_value,
      ios: ios_key_value,
      android: android_key_value
    }
  end

  def invalid_request_body
    {
      status: 422,
      request: request_key_value   
    }
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
