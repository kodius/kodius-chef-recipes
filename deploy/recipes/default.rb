include_recipe 'dependencies'

node[:deploy].each do |application, deploy|
  if 'flexcareers_workers' == application[:application_name]
    port 8080
  end
end