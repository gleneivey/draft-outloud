# Draft Outloud -- a RoR web app for serving a book's content while it is
#   being drafted
# Copyright (C) 2011 - Glen E. Ivey
#    https://github.com/gleneivey/draft-outloud
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License version
# 3 as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program in the file COPYING and/or LICENSE.  If not,
# see <http://www.gnu.org/licenses/>.


  #### NOTE: this deployment configuration is intended to deploy to
  ####   an instance on A2 Hosting.  It is configured for your
  ####   specific instance through environment variables.  We would
  ####   welcome a pull request that adds the ability to
  ####   (configurably) target other hosting providers as well.


def get_env(var_name)
  if ENV[var_name].nil? || ENV[var_name] == ''
    puts STDOUT, "the #{var_name} environment variable must be present"
    exit 1
  end
  ENV[var_name]
end


set :application, get_env('DO_CAP_APPLICATION')
set :repository,  get_env('DO_CAP_REPOSITORY')

set :scm, :git
set :branch, 'master'
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
set :bundle_flags, ''
set :use_sudo, false

set :a2_port,        get_env('DO_CAP_A2_PORT').to_i
set :deploy_to,      get_env('DO_CAP_A2_DEPLOY_DIR')
ssh_options[:port] = get_env('DO_CAP_A2_SSH').to_i
set :user,           get_env('DO_CAP_A2_USER')


require 'bundler/capistrano'

role :app, get_env('DO_CAP_APP_ROLE')
role :web, get_env('DO_CAP_WEB_ROLE'), :deploy => false
role :db,  get_env('DO_CAP_DB_ROLE'), :primary => true


namespace :deploy do
  desc "Start the app servers"
  task :start, :roles => :app do
    a2_mongrel_start
  end

  desc "Stop the app servers"
  task :stop, :roles => :app do
    a2_mongrel_stop
  end

  desc "Restart the app servers"
  task :restart, :roles => :app do
    a2_mongrel_stop
    a2_mongrel_start
  end
end

def a2_mongrel_start
  run "cd #{current_path} && " +
      "bundle exec mongrel_rails start -d -p #{a2_port} -e production -P log/mongrel.pid < /dev/null >& /dev/null"
end

def a2_mongrel_stop
  run "cd #{current_path} && bundle exec mongrel_rails stop"
end
