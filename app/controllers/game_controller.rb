class GameController < ApplicationController
  def alexa
    input = AlexaRubykit.build_request(params)
    output = AlexaRubykit::Response.new
    session_end = true
    message = "There was not an error." # unknown thing happened

    given = input.slots["Generic"].value
    message = "You said, #{given}."

    output.add_speech(message) unless message.blank?
    render json: output.build_response(session_end)
  end
end
