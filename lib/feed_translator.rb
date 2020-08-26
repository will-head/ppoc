require 'addressable/uri'

class FeedTranslator

  def initialize(feed_url)
    @feed_url = feed_url
    @uri = Addressable::URI.parse(feed_url)
  end

  def http
    @feed_url
  end

  def feed
    replace_scheme(@uri, __method__.to_s)
  end

  def itpc
    replace_scheme(@uri, __method__.to_s)
  end

  def podcast
    replace_scheme(@uri, __method__.to_s)
  end

  private

  def replace_scheme(uri, scheme)
    uri.scheme = scheme
    uri.to_s
  end
end
