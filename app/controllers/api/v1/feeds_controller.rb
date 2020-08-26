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
            feed_title: "",
            feed_url: ""
          }, 
          overcast: {
            feed_title: "",
            feed_url: ""
          }, 
          castro: {
            feed_title: "",
            feed_url: ""
          }, 
          pocket_casts: {
            feed_title: "",
            feed_url: ""
          }, 
          downcast: {
            feed_title: "",
            feed_url: ""
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
