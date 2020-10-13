class FeedFormatter

  def initialize(translated_feed)
  end

  def body
    {
      request: { feed: 'http://example.com/feed' },
      desktop: nil,
      ios: nil,
      android: nil
    }
  end

end
