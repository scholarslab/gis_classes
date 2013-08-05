require "bundler/capistrano"

set :application, "gis_classes"
set :repository,  "git://github.com/waynegraham/gis_classes.git"

set :scm, :git

server 'heron.lib.virginia.edu', :app, :web, :db, :primary => true

set :deploy_via, :remote_cache

set :deploy_to, "/usr/local/projects/#{application}"

set :use_sudo, false

default_run_options[:pty] = true


namespace :deploy do
  task :start do ; end
  task :end do ; end

  task :add_courses_link do
    run "cd #{current_path}/public && ln -s #{shared_path}/courses"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end

  task :finalize_update, :except => { :no_release => true } do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)
  end

  task :remove_rvmrc do
    run "rm #{current_path}/.rvmrc"
  end

end

after "deploy:create_symlink", "deploy:add_courses_link"
after "deploy", "deploy:cleanup", "deploy:remove_rvmrc"

