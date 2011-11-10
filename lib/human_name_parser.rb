require "human_name_parser/version"

module HumanNameParser
  autoload :Name, 'human_name_parser/name'

  def self.parse input_string
    return Name.new(input_string)
  end
end
