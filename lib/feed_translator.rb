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
    replace_scheme(@uri, __callee__.to_s)
  end

  alias_method :itpc, :feed
  alias_method :podcast, :feed
  alias_method :pcast, :feed
  alias_method :downcast, :feed

  private

  def replace_scheme(uri, scheme)
    uri.scheme = scheme
    uri.to_s
  end
end
