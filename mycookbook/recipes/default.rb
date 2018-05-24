#hostname=node[:opsworks][:instance][:hostname]\
instance = search("aws_opsworks_instance").first
Chef::Log.info("********** The instance's hostname is '#{instance['hostname']}' **********")
chef::Log.info("********** The instance's ID is '#{instance['instance_id']}' **********")
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
