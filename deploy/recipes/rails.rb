include_recipe 'deploy'

node[:deploy].each do |application, deploy|

  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping deploy::rails application #{application} as it is not a Rails app")
    next
  end

  case deploy[:database][:type]
  when "mysql"
    include_recipe "mysql::client_install"
  when "postgresql"
    include_recipe "opsworks_postgresql::client_install"
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_rails do
    deploy_data deploy
    app application
  end

  opsworks_deploy do
    deploy_data deploy
    app application

    if new_resource.environment['APACHE_SPECTRUM_SUPPORT'] == 'true'
      Chef::Log.info('DEPLOY: Modifying Apache Vhosts so Spectrum UI can run on port 80')
      CONFIG_PATH = '/etc/apache2/sites-available/flexcareers_workers.conf'.freeze
      Chef::Log.info('pre-block inside deploy')
      config_file = ::File.readlines(CONFIG_PATH)
      Chef::Log.info(config_file[0].to_s)
      if config_file[0].include? 'VirtualHost *:80'
        config_file[0].gsub!('80', '8080')
        ::File.open(CONFIG_PATH, 'w') { |f| f.write(config_file.join) }
        Chef::Log.info('hey I actually did something')
      end
      read_changed_file = ::File.readlines(CONFIG_PATH)
      Chef::Log.info(read_changed_file[0].to_s)
      Chef::Log.info('post-block inside deploy')
    end

  end
end
