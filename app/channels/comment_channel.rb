# class CommentChannel < ApplicationCable::Channel
#   def subscribed
#     stream_from "comment_channel"
#   end
#
#   def unsubscribed
#     #any thing
#   end
#
#   def speak(data)
#     ActionCable.server.broadcast "comment_channel", content: data['message']
#   end
# end
