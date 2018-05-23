hostname = node["opsworks"]["instance"]["hostname"]
file '/etc/hostname' do
    content "#{hostname}\n"
    mode '0644'
end

execute "sed -i /etc/sysconfig/network -e 's/^HOSTNAME=.*/HOSTNAME=#{hostname}/'" do
    only_if { node['hostname'] != hostname }
end

execute "hostname #{hostname}" do
    only_if { node['hostname'] != hostname }
end
