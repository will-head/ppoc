class FeedTranslator

  def initialize(feed_url)
    @feed_url = feed_url
  end

  def http
    @feed_url
  end

end
