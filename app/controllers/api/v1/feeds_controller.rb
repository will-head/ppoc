require 'feed_translator'

module Api::V1
  class FeedsController < ApiController

    def create
      @feed = FeedTranslator.new(profile_params.fetch(:feed))
      render json: body
    end

    protected

    # rubocop:disable Metrics/MethodLength
    def body
      {
        request: {
          feed:  profile_params.fetch(:feed)
        },
        desktop: {
          default: {
            feed_title: "Default",
            feed_url: @feed.feed
          },
          rss: {
            feed_title: "RSS",
            feed_url: @feed.http
          },
          itunes: {
            feed_title: "iTunes",
            feed_url: @feed.itpc
          },
          apple_podcasts: {
            feed_title: "Apple Podcasts",
            feed_url: @feed.podcast
          }
        },
        ios: {
          default: {
            feed_title: "Default",
            feed_url: @feed.feed
          }, 
          apple_podcasts: {
            feed_title: "Apple Podcasts",
            feed_url: @feed.podcast
          }, 
          overcast: {
            feed_title: "Overcast",
            feed_url: "overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed"
          }, 
          castro: {
            feed_title: "Castro",
            feed_url: @feed.castro
          }, 
          pocket_casts: {
            feed_title: "Pocket Casts",
            feed_url: @feed.pktc
          }, 
          downcast: {
            feed_title: "Downcast",
            feed_url: @feed.downcast
          }
        },
        android: {
          default: {
            feed_title: "Default",
            feed_url: @feed.pcast           
          }
        }
      }
    end
    # rubocop:enable Metrics/MethodLength

    def profile_params
      params
        .require(:data)
        .permit(:feed)
    end
  end
end
