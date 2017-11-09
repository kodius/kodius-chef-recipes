include_recipe 'dependencies'

node[:deploy].each do |application, deploy|
  if 'flexcareers_workers' == params[:name]
    port 8080
    params[:server_port] = 8080
  end
end