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

  def castro
    add_subscribe_prefix_to_feed(replace_scheme(@uri, __callee__.to_s))
  end

  alias_method :pktc, :castro

  private

  def replace_scheme(uri, scheme)
    uri.scheme = scheme
    uri.to_s
  end

  def add_subscribe_prefix_to_feed(uri)
    add_prefix_to_feed(uri, "subscribe/")
  end

  def add_prefix_to_feed(uri, prefix)
    split = uri.to_s.split('://')
    split[0] + "://" + prefix + split[1]
  end
end
