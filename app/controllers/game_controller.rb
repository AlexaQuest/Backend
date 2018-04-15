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
      session_end = false
    when "INTENT_REQUEST"
      case input.name
      when "AMAZON.CancelIntent"
        message = "what the heck do you want me to cancel?"
      when "AMAZON.HelpIntent"
        # our custom, simple intent from above that user matched
        message = "ok u asked for help!"
      when "AMAZON.StopIntent"
        message = "okay, ending game."
        session_end = true
      end
    when "SESSION_ENDED_REQUEST"
      # it's over
      message = "session over!"
      session_end = true
    end

    output.add_speech(message) unless message.blank?
    render json: output.build_response(session_end)
  end
end
