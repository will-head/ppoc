require 'addressable/uri'
require 'cgi'

class FeedTranslator
  VALID_SCHEMES = ["http", "https"]

  def initialize(request)
    @request = request
    @feed_url = @request
    @uri = valid_request?
  end

  def valid_request?
    return false unless @request.is_a?(String)
    return false if @request.empty?
    
    uri = Addressable::URI.parse(@request)
    return uri if uri.scheme.in?(VALID_SCHEMES)

    false
    rescue Addressable::URI::InvalidURIError
      false
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
    add_subscribe_prefix_to_feed(replace_feed_scheme(@uri, __callee__.to_s))
  end

  def format_feed_with_new_scheme_add_x_callback_url
    __callee__.to_s + "://x-callback-url/add?url=" + CGI::escape(@feed_url)
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

  def add_prefix_to_feed(uri, prefix)
    split = uri.to_s.split('://')
    split[0] + "://" + prefix + split[1]
  end

  def add_subscribe_prefix_to_feed(uri)
    add_prefix_to_feed(uri, "subscribe/")
  end
end
