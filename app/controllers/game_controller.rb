class GameController < ApplicationController
  def alexa
    input = AlexaRubykit.build_request(params)
    output = AlexaRubykit::Response.new
    session_end = false
    message = "There was not an error." # unknown thing happened

    case input.type
    when "LAUNCH_REQUEST"
      message = "Welcome to AlexaQuest."
    when "INTENT_REQUEST"
      case input.name
      when "attack"
        output.add_speech "ATTACK!"
        @@current_txt = @@current_txt + [input.name]
      when "spin"
        output.add_audio_url(root_url + "spin.mp3", "token-here")
        @@current_txt = @@current_txt + [input.name]
      when "block"
        output.add_speech "block time"
        @@current_txt = @@current_txt + [input.name]
      when "shoot"
        output.add_speech "firing weapon"
        @@current_txt = @@current_txt + [input.name]
      when "cover"
        message = "going into cover"
        @@current_txt = @@current_txt + [input.name]
      when "heal"
        message = "looking for medical supplies"
        @@current_txt = @@current_txt + [input.name]
      when "charge"
        message = "charging next attack"
        @@current_txt = @@current_txt + [input.name]
      when "AMAZON.HelpIntent"
        output.add_speech "say attack, spin, block, shoot, cover, heal, or charge."
      when "AMAZON.CancelIntent"
        # session_end = true
      when "AMAZON.StopIntent"
        session_end = true
      end
    when "SESSION_ENDED_REQUEST"
      session_end = true
    end

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
