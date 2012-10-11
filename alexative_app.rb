class AlexativeApp < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/public'
  set :haml, format: :html5

  get "/" do
    user_agent = UserAgent.new env["HTTP_USER_AGENT"].to_s
    if user_agent.name == :ie
      erb :ie, content_type: "text/plain"
    else
      haml :index
    end
  end

  get "/application.css" do
    sass :application
  end

  get "/application.js" do
    coffee :application
  end
end
