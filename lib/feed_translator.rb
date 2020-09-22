require 'addressable/uri'
require 'cgi'

class FeedTranslator
  attr_reader :feed_url

  def initialize(feed_url)
    @feed_url = feed_url
    @uri = Addressable::URI.parse(feed_url)
  end

  def desktop
    { 
      default: { feed_title: "Default", feed_url: feed }
    }
  end

  def format_feed_with_new_scheme
    replace_feed_scheme(@uri, __callee__.to_s)
  end

  def format_feed_with_new_scheme_add_subscribe
    add_subscribe_prefix_to_feed(replace_feed_scheme(@uri, __callee__.to_s))
  end

  def format_feed_with_new_scheme_add_x_callback_url
    __callee__.to_s + "://x-callback-url/add?url=" + CGI::escape(@feed_url)
  end

  alias_method :http, :feed_url

  alias_method :feed, :format_feed_with_new_scheme
  alias_method :itpc, :format_feed_with_new_scheme
  alias_method :podcast, :format_feed_with_new_scheme
  alias_method :pcast, :format_feed_with_new_scheme
  alias_method :downcast, :format_feed_with_new_scheme

  alias_method :castro, :format_feed_with_new_scheme_add_subscribe
  alias_method :pktc, :format_feed_with_new_scheme_add_subscribe

  alias_method :overcast, :format_feed_with_new_scheme_add_x_callback_url

  private

  def replace_feed_scheme(uri, scheme)
    uri.scheme = scheme
    uri.to_s
  end

  def add_prefix_to_feed(uri, prefix)
    split = uri.to_s.split('://')
    split[0] + "://" + prefix + split[1]
  end

  def add_subscribe_prefix_to_feed(uri)
    add_prefix_to_feed(uri, "subscribe/")
  end

  private :format_feed_with_new_scheme, :format_feed_with_new_scheme_add_subscribe, \
          :format_feed_with_new_scheme_add_x_callback_url, :feed_url
end
