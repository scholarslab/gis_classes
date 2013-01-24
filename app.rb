require 'sinatra'
require 'erb'

configure :development do
  enable :logging, :dump_errors, :raise_erros
end

configure :production do
  set :raise_errors, false
  set :show_exceptions, false
end

configure do
  set :app_path, File.dirname(__FILE__)
  set :course_files, settings.app_path + '/courses'
  set :course_directories, '/courses'
end

before do
  @menu = {}
  Dir.glob "#{settings.course_files}/**" do |file|
    me, mi = file.split('/')[-1]
    @menu[me] ||= []
    @menu[me] << mi
  end
end

get '/' do
  @classes = list_directories
  erb :index
end

def list_directories
  Dir.glob(settings.course_files + "/**").select{|f| File.directory? f}
end


