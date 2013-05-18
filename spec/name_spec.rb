# encoding: utf-8
require 'human_name_parser/name'

NAMES = [
  ['', ['', '', '', '', '', '']],
  ['Downey, Robert Jr.', ['Robert', '', 'Downey', '', 'Jr.', 'RD']],
  ['Mr. Alphonse di Morel Jr. Esq.', ['Alphonse', '', 'di Morel', 'Mr.', 'Jr. Esq.', 'AD']],
  ['Mary Lou Smith', ['Mary', 'Lou', 'Smith', '', '', 'MLS']],
  ['Marley', ['Marley', '', '', '', '', 'M']],
  ['Marley Mante', ['Marley', '', 'Mante', '', '', 'MM']],
  ['Marley Mante PhD', ['Marley', '', 'Mante', '', 'PhD', 'MM']],
  ['Marley Mante, esq.', ['Marley', '', 'Mante', '', 'esq.', 'MM']],
  ['Amy and Brian Smith', ['Amy and Brian', '', 'Smith', '', '', 'AS']],
  ['Amy & Brian', ['Amy & Brian', '', '', '', '', 'A']],
  ["Björn Charles van der O'Malley", ['Björn', 'Charles', "van der O'Malley", '', '', 'BCV']],
  ['Alex Rothlenson-ben-Elsburghmohampton', ['Alex', '', 'Rothlenson-ben-Elsburghmohampton', '', '', 'AR']],
  ['1234 Anywhere St., North Pole, SD 22323', ['', '', '', '', '', '']]
]

describe HumanNameParser::Name do
  NAMES.each do |name_array|
    context "when full name is #{ name_array.first.inspect }" do
      before { @name = HumanNameParser::Name.new name_array.first }

      it "gets first name" do
        @name.first.should == name_array[1][0]
      end

      it "gets middle name" do
        @name.middle.should == name_array[1][1]
      end

      it "gets last name" do
        @name.last.should == name_array[1][2]
      end

      it "gets prefix" do
        @name.prefix.should == name_array[1][3]
      end

      it "gets suffix" do
        @name.suffix.should == name_array[1][4]
      end

      it "gets initials" do
        @name.initials.should == name_array[1][5]
      end
    end
  end
end
