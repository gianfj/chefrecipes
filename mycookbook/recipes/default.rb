instance = search("aws_opsworks_instance", "self:true").first
hostname="#{instance['hostname']}"

execute "sed -i /etc/sysconfig/network -e 's/^HOSTNAME=.*/HOSTNAME=#{hostname}/'" do
    only_if { node['hostname'] != hostname }
end

execute "hostname #{hostname}" do
    only_if { node['hostname'] != hostname }
end


Chef::Log.info("********** Instance hostname: '#{hostname}' **********")

