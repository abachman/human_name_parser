require 'human_name_parser'

describe HumanNameParser do
  it "returns a Name object" do
    name = HumanNameParser.parse ''
    name.class.should == HumanNameParser::Name
  end

  it "returns nil when given nil" do
    problem = nil
    name = HumanNameParser.parse problem
    name.should == problem
  end

  it "parses names" do
    name = HumanNameParser.parse "John H. Smith"
    name.first.should eq 'John'
    name.last.should eq 'Smith'
    name.initials.should eq 'JHS'
  end
end
