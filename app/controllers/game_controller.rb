class GameController < ApplicationController
  def alexa
    input = AlexaRubykit.build_request(params)
    output = AlexaRubykit::Response.new
    session_end = false
    message = "There was not an error." # unknown thing happened

    case input.type
    when "LAUNCH_REQUEST"
      message = "Say something see what happens."
    when "INTENT_REQUEST"
      case input.name
      when "attack"
        message = "oh yeah kill those enemies nice job"
      when "spin"
        message = "you spin me right round"
      when "block"
        message = "block time"
      when "shoot"
        message = "firing weapon"
      when "cover"
        message = "going into cover"
      when "heal"
        message = "looking for medical supplies"
      when "charge"
        message = "charging next attack"
      when "AMAZON.HelpIntent"
        message = "ok u asked for help!"
      when "AMAZON.CancelIntent"
        message = "okay, ending game."
        session_end = true
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

  def game
    render json: {game: true}
  end
end
