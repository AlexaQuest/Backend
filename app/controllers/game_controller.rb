class GameController < ApplicationController
  def alexa
    input = AlexaRubykit.build_request(params)
    output = AlexaRubykit::Response.new
    session_end = false
    message = "There was not an error." # unknown thing happened

    case input.type
    when "LAUNCH_REQUEST"
      output.add_speech "Welcome to AlexaQuest."
    when "INTENT_REQUEST"
      case input.name
      when "attack"
        output.add_speech "That'll leave a mark."
        @@current_txt = @@current_txt + [input.name]
      when "spin"
        output.add_speech "You spin me right round."
        @@current_txt = @@current_txt + [input.name]
      when "block"
        output.add_speech "I stand my ground."
        @@current_txt = @@current_txt + [input.name]
      when "shoot"
        output.add_speech "Incoming!"
        @@current_txt = @@current_txt + [input.name]
      when "cover"
        output.add_speech "Where's that rock?"
        @@current_txt = @@current_txt + [input.name]
      when "heal"
        output.add_speech "I'm out of potions!"
        @@current_txt = @@current_txt + [input.name]
      when "charge"
        output.add_speech "My blade is unwielding."
        @@current_txt = @@current_txt + [input.name]
      when "AMAZON.HelpIntent"
        output.add_speech "Say attack, spin, block, shoot, cover, heal, or charge to play."
      when "AMAZON.CancelIntent"
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
