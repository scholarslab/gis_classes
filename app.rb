require 'sinatra'
require 'erb'
require 'titleize'
require 'redcarpet'

require_relative 'helpers/init'

configure :development do
  enable :logging, :dump_errors, :raise_erros
end

configure :production do
  set :raise_errors, false
  set :show_exceptions, false
end

configure do
  set :app_path, File.dirname(__FILE__)
  set :course_files, settings.app_path + '/public/courses'
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

def get_files(dir)
  dir_pattern = settings.course_files + '/' + dir + '/**/*'

  Dir.glob(dir_pattern)
end

def get_readme(dir)
  begin
    path = "#{settings.course_files}/#{dir}/index.md"
    content = File.read(path)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      :autolink => true,
      :space_after_headers => true
    )

    markdown.render(content)
  rescue
    ''
  end

end

get '/' do
  erb :index
end

get '/about' do
  erb :about
end

get '/contact' do
  erb :contact
end

get '/courses' do
  erb :index
end

get '/courses/:course' do
  @files = get_files(params['course'])
  @content = get_readme(params['course'])
  erb :course
end

