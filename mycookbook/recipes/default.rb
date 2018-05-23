hostname = 'ahahahahh'
file '/etc/hostname' do
    content "#{hostname}\n"
    mode '0644'
end

execute "hostname #{hostname}" do
    only_if { node['hostname'] != hostname }
end
