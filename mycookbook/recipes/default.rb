instance = search("aws_opsworks_instance").first
hostname="#{instance['hostname']}"
#id="#{instance['instance_id']}"



#file '/etc/hostname' do
#    content "#{hostname}\n"
#    mode '0644'
#end

#execute "sed -i /etc/sysconfig/network -e 's/^HOSTNAME=.*/HOSTNAME=#{hostname}/'" do
#    only_if { node['hostname'] != hostname }
#end

#execute "hostname #{hostname}" do
#    only_if { node['hostname'] != hostname }
#end

def get_opsworks_hostname(instance_id)
  Chef::Log.info("********** Ran function **********")
  # Ensure aws-sdk is installed and create OpsWorks Client
  chef_gem "aws-sdk" do
    action :install
    compile_time true
  end
  require 'aws-sdk'
  Aws.use_bundled_cert!
  client = Aws::OpsWorks::Client.new(
    region: search("aws_opsworks_stack").first['region']
  )

  # Get instance Hostname
  instance_resp = client.describe_instances({
    instance_ids: [instance_id]
  })
  return instance_resp.instances[0].hostname
end

Chef::Log.info("********** Instance Hostname: get_opsworks_hostname(#{instance['instance_id']})' **********")

