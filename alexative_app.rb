class AlexativeApp < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/public'
  set :haml, format: :html5

  get "/" do
    haml :index
  end

  get "/application.css" do
    sass :application
  end

  get "/application.js" do
    coffee :application
  end
end
