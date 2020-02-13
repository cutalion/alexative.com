# frozen_string_literal: true

require 'slim'

class AlexativeApp < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/public'

  get '/' do
    slim :index
  end

  get '/application.css' do
    sass :application
  end
end
