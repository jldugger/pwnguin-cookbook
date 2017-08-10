# # encoding: utf-8

# Inspec test for recipe pwnguin::database

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe command('logrotate -d /etc/logrotate.d/postgresql-backups') do
  its('exit_status') { should eq 0 }
end
