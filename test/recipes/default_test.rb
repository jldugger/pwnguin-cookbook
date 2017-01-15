# # encoding: utf-8

# Inspec test for recipe pwnguin::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe port(80) do
  it { should be_listening }
end

describe command('curl http://localhost/albums/ -H "Host: pwnguin.net"') do
  its(:stdout) { should match(/A collection of my personal photos/) }
end

describe port(443) do
  it { should be_listening }
end

describe command('curl --insecure https://localhost/albums/ -H "Host: pwnguin.net"') do
  its(:stdout) { should match(/A collection of my personal photos/) }
end
