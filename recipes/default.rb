hostname = 'ahahahahh'
file '/etc/hostname' do
    content "#{hostname}\n"
    mode '0644'
    notifies :reload, 'ohai[reload_hostname]', :immediately
end

execute "hostname #{hostname}" do
    only_if { node['hostname'] != hostname }
    notifies :reload, 'ohai[reload_hostname]', :immediately
end
