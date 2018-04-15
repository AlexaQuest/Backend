class HomeController < ApplicationController
  def index
    render html: "<h1>This is the AlexaQuest API</h1>".html_safe
  end
end
