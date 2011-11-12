require 'human_name_parser/name'

describe HumanNameParser::Name do
  # any unicode issues?
  context "when full name is Björn Charles van der O'Malley" do
    let(:full_name) { "Björn Charles van der O'Malley" }
    it "should parse the name" do
      @name = HumanNameParser::Name.new full_name
      @name.first.should == 'Björn'
      @name.last.should == "van der O'Malley"
      @name.middle.should == 'Charles'
    end
  end

  context "when full name is Marley Mante PhD" do
    let(:full_name) { "Marley Mante PhD" }
    it "should parse the name" do
      @name = HumanNameParser::Name.new full_name
      @name.first.should == 'Marley'
      @name.last.should == 'Mante'
      @name.middle.should == ''
      @name.suffix.should == 'PhD'
    end
  end

  context "when full name is Marley Mante" do
    let(:full_name) { "Marley Mante" }
    it "should parse the name" do
      @name = HumanNameParser::Name.new full_name
      @name.first.should == 'Marley'
      @name.last.should == 'Mante'
      @name.middle.should == ''
      @name.suffix.should == ''
    end
  end

  context "when full name is Marley" do
    let(:full_name) { "Marley" }
    it "should parse the name" do
      @name = HumanNameParser::Name.new full_name
      @name.first.should == 'Marley'
      @name.last.should == ''
      @name.middle.should == ''
      @name.suffix.should == ''
    end
  end

  context "when full name is Marley Mante, esq." do
    let(:full_name) { "Marley Mante, esq." }
    it "should parse the name" do
      @name = HumanNameParser::Name.new full_name
      @name.first.should == 'Marley'
      @name.last.should == 'Mante'
      @name.middle.should == ''
      @name.suffix.should == 'esq.'
    end
  end

  context 'when full name is Mary Lou Smith' do
    let(:full_name) { "Mary Lou Smith" }
    before do
      @name = HumanNameParser::Name.new full_name
    end

    it "gets first name" do
      @name.first.should == 'Mary'
    end

    it "gets last name" do
      @name.last.should == 'Smith'
    end

    it "gets middle" do
      @name.middle.should == 'Lou'
    end

    it "gets prefix" do
      @name.prefix.should == ''
    end

    it "gets suffix" do
      @name.suffix.should == ''
    end

    it "gets initials" do
      @name.initials.should == 'MLS'
    end
  end

  context 'when full name is Mr. Alphonse di Morel Jr. Esq.' do
    let(:full_name) { "Mr. Alphonse di Morel Jr. Esq." }
    before { @name = HumanNameParser::Name.new full_name }

    it "gets first" do
      @name.first.should == 'Alphonse'
    end

    it "gets last" do
      @name.last.should == 'di Morel'
    end

    it "gets prefix" do
      @name.prefix.should == 'Mr.'
    end

    it "gets suffix" do
      @name.suffix.should == 'Jr. Esq.'
    end

    it "gets initials" do
      @name.initials.should == 'AD'
    end
  end

  context 'when full name is ROBOTO' do
    let(:full_name) { "ROBOTO" }
    before { @name = HumanNameParser::Name.new full_name }

    it "gets first" do
      @name.first.should == 'ROBOTO'
    end

    it 'gets initials' do
      @name.initials.should == 'R'
    end

    it "doesn't get last" do
      @name.last.should == ''
    end
  end

  context 'when full name is Downey Jr., Robert' do
    let(:full_name) { 'Downey Jr., Robert' }
    before { @name = HumanNameParser::Name.new full_name }

    it "gets first" do
      @name.first.should == 'Robert'
    end

    it 'gets initials' do
      @name.initials.should == 'RD'
    end

    it "gets last" do
      @name.last.should == 'Downey'
    end

    it "gets middle" do
      @name.middle.should == ''
    end

    it "gets suffix" do
      @name.suffix.should == 'Jr.'
    end
  end

  context 'when full name is garbage' do
    let(:full_name) { '1234 Anywhere St., North Pole, SD 22323' }
    before { @name = HumanNameParser::Name.new full_name }

    it "gets first" do
      @name.first.should == ''
    end

    it 'gets initials' do
      @name.initials.should == ''
    end

    it "gets last" do
      @name.last.should == ''
    end

    it "gets middle" do
      @name.middle.should == ''
    end

    it "gets suffix" do
      @name.suffix.should == ''
    end
  end
end
