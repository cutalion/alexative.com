# frozen_string_literal: true

require 'open-uri'

class AlexativeApp < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/public'
  set :haml, format: :html5

  get '/' do
    haml :index
  end

  get '/application.css' do
    sass :application
  end
end
