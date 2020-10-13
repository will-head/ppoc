class FeedFormatter

  def initialize(translated_feed)
    @translated_feed = translated_feed
  end

  def body
    {
      request: { feed: @translated_feed.request },
      desktop: desktop,
      ios: ios,
      android: nil
    }
  end

  def desktop
    { 
      default: { feed_title: "Default", feed_url: @translated_feed.feed },
      rss: { feed_title: "RSS", feed_url: @translated_feed.http },
      itunes: { feed_title: "iTunes", feed_url: @translated_feed.itpc },
      apple_podcasts: { feed_title: "Apple Podcasts", feed_url: @translated_feed.podcast }
    }
  end

  def ios
    {
      default: { feed_title: "Default", feed_url: @translated_feed.feed },
      apple_podcasts: { feed_title: "Apple Podcasts", feed_url: @translated_feed.podcast },
      overcast: { feed_title: "Overcast", feed_url: @translated_feed.overcast },
      castro: { feed_title: "Castro", feed_url: @translated_feed.castro },
      pocket_casts: { feed_title: "Pocket Casts", feed_url: @translated_feed.pktc },
      downcast: { feed_title: "Downcast", feed_url: @translated_feed.downcast }
    }
  end
end
