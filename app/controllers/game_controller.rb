class GameController < ApplicationController
  def alexa
    input = AlexaRubykit.build_request(params)
    output = AlexaRubykit::Response.new
    session_end = true
    message = "There was not an error." # unknown thing happened

    case input.type
    when "LAUNCH_REQUEST"
      # user talked to our skill but did not say something matching intent
      message = "Say something see what happens."
    when "INTENT_REQUEST"
      # our custom, simple intent from above that user matched
      given = input.slots["Generic"].value
      message = "You said, #{given}."
    when "SESSION_ENDED_REQUEST"
      # it's over
      message = "session over!"
    end

    output.add_speech(message) unless message.blank?
    render json: output.build_response(session_end)
  end
end
