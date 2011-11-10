Attempt to parse and categorize the parts of names.

With code borrowed from:

* https://github.com/bricooke/name_parser
* https://github.com/jasonpriem/HumanNameParser.php
* https://github.com/jconley88/NameParser

## Install

`gem install human_name_parser`

## Usage

    require 'rubygems'
    require 'human_name_parser'

    name = HumanNameParser.parse 'George W. Bush Jr.'
    name.first    # => 'George'
    name.last     # => 'Bush'
    name.initials # => 'GWB'
    name.suffix   # => 'Jr.'
    name.to_s     # => 'George W. Bush Jr.'

## Development

    ~/ $ git clone ... && cd human_name_parser
    ~/ $ bundle install
    ~/ $ rake

## TODO

Handle nicknames

Handle strangely placed commas

Handle multiple last names. e.g., "Björn Charles O'Malley y Muñoz"

Handle multiple first names. e.g., "Mary Joe Francis Smith"
