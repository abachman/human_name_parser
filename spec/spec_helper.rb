$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'human_name_parser'
require 'rspec'

RSpec.configure do |c|
  c.mock_with :rspec
end
