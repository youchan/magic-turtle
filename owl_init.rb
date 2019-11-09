env = defined?(Rails) ? Rails.env : ENV['RACK_ENV']
env = 'development' unless env
puts "ENV=#{env}"
if env != 'development'
  OpalWebpackLoader.client_asset_path = '' # the full path is in the manifest already, like: /assets/application-97fd9c2b7e7bdb112fc1.js
  OpalWebpackLoader.manifest_path = 'public/assets/manifest.json'
  OpalWebpackLoader.use_manifest = true
else
  OpalWebpackLoader.client_asset_path = 'http://localhost:3035/assets/'
  OpalWebpackLoader.manifest_path = nil
  OpalWebpackLoader.use_manifest = false
end
