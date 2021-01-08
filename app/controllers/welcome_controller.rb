class WelcomeController < ApplicationController
  def index
    render layout: 'mailer'
  end
end
