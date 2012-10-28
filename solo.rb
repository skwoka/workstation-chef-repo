log_level :info
user       = ENV['KASHOO_USER']     || ENV['USER']
chef_repo  = ENV['CHEF_REPO']       || File.expand_path(File.dirname(__FILE__))
#chef_repo  = ENV['CHEF_REPO']       || File.expand_path(File.dirname(__FILE__) + "/../../chef-repo")

chef_working_dir="/tmp/chef"
node_name "#{user}-workstation"

puts "
Configuring your workstation with the following:
  chef repo       : #{chef_repo}
  kashoo user     : #{user}
  home directory  : #{ENV['HOME']}
  workstation name: #{node_name}

"

cache_type "BasicFile"
cache_options({ :path => platform_specific_path("#{chef_working_dir}/cache/checksums"), :skip_expires => true })

# Where files are stored temporarily during uploads
sandbox_path "#{chef_working_dir}/sandboxes"

# Where cookbook files are stored on the server (by content checksum)
checksum_path "#{chef_working_dir}/checksums"

# Where chef's cache files should be stored
file_cache_path "#{chef_working_dir}/cache"

# Where backups of chef-managed files should go
file_backup_path "#{chef_working_dir}/backup"

cookbook_path ["#{chef_repo}/cookbooks"]
role_path "#{chef_repo}/roles"
data_bag_path "#{chef_repo}/data_bags"
encrypted_data_bag_secret "/tmp/encrypted_data_bag_secret"

http_proxy nil
http_proxy_user nil
http_proxy_pass nil
https_proxy nil
https_proxy_user nil
https_proxy_pass nil
no_proxy nil
