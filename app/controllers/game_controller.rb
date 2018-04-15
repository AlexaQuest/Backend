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
        @@current_txt = @@current_txt_ + [input.name]
      when "spin"
        message = "you spin me right round"
        @@current_txt = @@current_txt_ + [input.name]
      when "block"
        message = "block time"
        @@current_txt = @@current_txt_ + [input.name]
      when "shoot"
        message = "firing weapon"
        @@current_txt = @@current_txt_ + [input.name]
      when "cover"
        message = "going into cover"
        @@current_txt = @@current_txt_ + [input.name]
      when "heal"
        message = "looking for medical supplies"
        @@current_txt = @@current_txt_ + [input.name]
      when "charge"
        message = "charging next attack"
        @@current_txt = @@current_txt_ + [input.name]
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
      message = "session over!"
      session_end = true
    end

    output.add_speech(message) unless message.blank?
    render json: output.build_response(session_end)
  end

  @@current_txt = []

  def game
    if !@@current_txt.empty?
      render html: @@current_txt[0]
      @@current_txt = @@current_txt[1..-1]
    else
      render html: ""
    end
  end
end
