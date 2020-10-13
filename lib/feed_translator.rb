require 'addressable/uri'
require 'cgi'
require 'open-uri'

class FeedTranslator
  VALID_SCHEMES = ["http", "https", "feed", "itpc", "podcast", 
    "overcast", "castro", "pktc", "downcast", "pcast"]

  SUBSCRIBE_PREFIX = ["castro", "pktc"]

  XCALLBACK_SCHEMES = ["overcast"]

  attr_reader :request 

  def initialize(request)
    @request = request
    @source_feed = @request
    @uri = valid_request?
  end

  def format_feed_with_new_scheme
    replace_feed_scheme(@uri, __callee__.to_s)
  end

  alias_method :feed, :format_feed_with_new_scheme
  alias_method :http, :format_feed_with_new_scheme
  alias_method :itpc, :format_feed_with_new_scheme
  alias_method :podcast, :format_feed_with_new_scheme
  alias_method :downcast, :format_feed_with_new_scheme
  alias_method :pcast, :format_feed_with_new_scheme

  def format_feed_with_new_scheme_add_subscribe
    add_feed_prefix(replace_feed_scheme(@uri, __callee__.to_s), "subscribe/")
  end

  alias_method :castro, :format_feed_with_new_scheme_add_subscribe
  alias_method :pktc, :format_feed_with_new_scheme_add_subscribe

  def format_feed_with_new_scheme_add_x_callback_url
    @source_feed = remove_feed_prefix(@request, "subscribe/") \
      if feed_prefix?(@source_feed, "subscribe/")
    source_feed_uri = Addressable::URI.parse(@source_feed)
    @source_feed = replace_feed_scheme(source_feed_uri, "http") \
      unless source_feed_uri.scheme.in?(["http", "https"]) 
    __callee__.to_s + "://x-callback-url/add?url=" + CGI::escape(@source_feed)
  end

  alias_method :overcast, :format_feed_with_new_scheme_add_x_callback_url

  def valid_request?
    return false unless @request.is_a?(String)

    uri = Addressable::URI.parse(@request)

    valid_scheme?(uri)
  rescue Addressable::URI::InvalidURIError 
    false
  end

  private

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
      @source_feed = Addressable::URI.parse(@request).query_values["url"]
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
  # rubocop:disable Style/AccessModifierDeclarations
  private :format_feed_with_new_scheme
  private :format_feed_with_new_scheme_add_subscribe
  private :format_feed_with_new_scheme_add_x_callback_url
  # rubocop:enable Style/AccessModifierDeclarations
end
