require 'human_name_parser'

describe HumanNameParser do
  it "returns a Name object" do
    name = HumanNameParser.parse ''
    name.class.should == HumanNameParser::Name
  end

  it "parses names" do
    name = HumanNameParser.parse "John H. Smith"
    name.first.should == 'John'
    name.last.should == 'Smith'
    name.initials.should == 'JHS'
  end
end
