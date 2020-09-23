require 'addressable/uri'
require 'cgi'

class FeedTranslator
  VALID_SCHEMES = ["http", "https", "feed", "itpc", "podcast", 
    "overcast", "castro", "pktc", "downcast", "pcast"]

  SUBSCRIBE_PREFIX = ["castro", "pktc"]

  XCALLBACK_SCHEMES = ["overcast"]

  def initialize(request)
    @request = request
    @feed = @request
    @uri = valid_request?
  end

  def valid_request?
    return false unless @request.is_a?(String)

    uri = Addressable::URI.parse(@request)

    valid_scheme?(uri)
    rescue Addressable::URI::InvalidURIError 
      false
  end

  def valid_scheme?(uri)
    if uri.scheme.in?(VALID_SCHEMES)
      uri = xcallback_scheme(uri)
      return subscribe_prefix?(uri)
    end

    false
  end

  def xcallback_scheme(uri)
    if uri.scheme.in?(XCALLBACK_SCHEMES)
      uri = Addressable::URI.parse(uri.query_values["url"])
      @feed = Addressable::URI.parse(@request).query_values["url"]
    end

    uri
  end

  def subscribe_prefix?(uri)
    if uri.scheme.in?(SUBSCRIBE_PREFIX)
      return false unless feed_prefix?(@request, "subscribe/")

      uri = Addressable::URI.parse(remove_feed_prefix(@request, "subscribe/"))
    end
    uri
  end

  def body
    {
      request: request,
      desktop: desktop,
      ios: ios,
      android: android
    }
  end

  private

  def request
    { feed: @request }
  end

  def desktop
    { 
      default: { feed_title: "Default", feed_url: feed },
      rss: { feed_title: "RSS", feed_url: http },
      itunes: { feed_title: "iTunes", feed_url: itpc },
      apple_podcasts: { feed_title: "Apple Podcasts", feed_url: podcast }
    }
  end

  def ios
    {
      default: { feed_title: "Default", feed_url: feed },
      apple_podcasts: { feed_title: "Apple Podcasts", feed_url: podcast },
      overcast: { feed_title: "Overcast", feed_url: overcast },
      castro: { feed_title: "Castro", feed_url: castro },
      pocket_casts: { feed_title: "Pocket Casts", feed_url: pktc },
      downcast: { feed_title: "Downcast", feed_url: downcast }
    }
  end

  def android
    {
      default: { feed_title: "Default", feed_url: pcast }
    }
  end

  def format_feed_with_new_scheme
    replace_feed_scheme(@uri, __callee__.to_s)
  end

  def format_feed_with_new_scheme_add_subscribe
    add_feed_prefix(replace_feed_scheme(@uri, __callee__.to_s), "subscribe/")
  end

  def format_feed_with_new_scheme_add_x_callback_url
    @feed = remove_feed_prefix(@request, "subscribe/") if feed_prefix?(@feed, "subscribe/")
    feed_uri = Addressable::URI.parse(@feed)
    @feed = replace_feed_scheme(feed_uri, "http") unless feed_uri.scheme.in?(["http", "https"]) 
    __callee__.to_s + "://x-callback-url/add?url=" + CGI::escape(@feed)
  end

  alias_method :http, :format_feed_with_new_scheme
  alias_method :feed, :format_feed_with_new_scheme
  alias_method :itpc, :format_feed_with_new_scheme
  alias_method :podcast, :format_feed_with_new_scheme
  alias_method :pcast, :format_feed_with_new_scheme
  alias_method :downcast, :format_feed_with_new_scheme

  alias_method :castro, :format_feed_with_new_scheme_add_subscribe
  alias_method :pktc, :format_feed_with_new_scheme_add_subscribe

  alias_method :overcast, :format_feed_with_new_scheme_add_x_callback_url

  def replace_feed_scheme(uri, scheme)
    uri.scheme = scheme
    uri.to_s
  end

  def feed_prefix?(feed, prefix)
    split = feed.to_s.split('://')
    split[1].start_with?(prefix)
  end

  def add_feed_prefix(feed, prefix)
    split = feed.to_s.split('://')
    split[0] + "://" + prefix + split[1]
  end

  def remove_feed_prefix(feed, prefix)
    split = feed.to_s.split('://')
    split[0] + "://" + split[1].delete_prefix(prefix)
  end
end
