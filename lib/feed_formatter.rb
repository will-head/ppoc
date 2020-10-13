class FeedFormatter

  def initialize(translated_feed)
    @translated_feed = translated_feed
  end

  def body
    {
      request: { feed: @translated_feed.request },
      desktop: nil,
      ios: nil,
      android: nil
    }
  end

end
