require 'bundler/setup'
if ENV['RACK_ENV'] && ENV['RACK_ENV'] == 'test'
  Bundler.require(:default, :test)
elsif ENV['RACK_ENV'] && ENV['RACK_ENV'] == 'production'
  Bundler.require(:default, :production)
else
  Bundler.require(:default, :development)
end
Opal.append_path(File.realdirpath('app'))
