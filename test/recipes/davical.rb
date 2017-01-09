# # encoding: utf-8

# Inspec test for recipe pwnguin::davical

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe port(80) do
  it { should be_listening }
end

describe command('curl localhost -H 'Host: calendar.pwnguin.net') do
  its(:stdout) {should match /DAViCal/}
