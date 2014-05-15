package 'nginx'

service 'nginx' do
  supports restart: true, reload: true
  action [:start]
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  notifies :reload, 'service[nginx]'
end
