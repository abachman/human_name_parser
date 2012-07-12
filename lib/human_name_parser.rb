require "human_name_parser/version"

module HumanNameParser
  autoload :Name, 'human_name_parser/name'

  def self.parse input_string
    if input_string.nil?
      nil
    else
      Name.new(input_string)
    end
  end
end
