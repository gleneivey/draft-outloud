
require 'aruba/cucumber'

Before do
  ENV['PATH'] = '' + File.expand_path(File.dirname(__FILE__) + '/../../tools') +
                  File::PATH_SEPARATOR + ENV['PATH']
  @aruba_timeout_seconds = 60
end
