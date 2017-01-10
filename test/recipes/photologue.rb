# # encoding: utf-8

# Inspec test for recipe pwnguin::photologue

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe port(80) do
  it { should be_listening }
end

describe command('curl localhost -H "Host: albums.pwnguin.net"') do
  its(:stdout) {should match /photologue/}
end

describe command('curl localhost/admin/login/?next=/admin/ -H "albums.pwnguin.net"') do
  its(:stdout) {should match /administration/}
end
