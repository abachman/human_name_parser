module HumanNameParser
  class Name
    PREFIXES = ['mr', 'ms', 'miss', 'mrs', 'sir', 'prof', 'professor', 'md', 'dr']
    SUFFIXES = ['esq','esquire','jr','sr','2', 'i', 'ii','iii','iv', 'v', 'phd', 'md', 'do', 'dc', 'dds']
    LAST_PREFIXES = ['al', 'bar','ben','bin','da','dal','de la', 'de', 'del', 'der', 'di', 'el', 'ibn', 'la', 'le', 'mc', 'san', 'st', 'ste', 'van', 'van der', 'van den', 'vel','von']
    NAME_JOINERS = ['&', 'and']

    attr_accessor :first, :middle, :last, :prefix, :suffix

    def initialize name
      self.first  = ''
      self.middle = ''
      self.last   = ''
      self.prefix = ''
      self.suffix = ''

      @input_string = name

      parse
    end

    def parse
      normalize_and_split

      if @split_name.length == 1
        _first, _ = @split_name
        self.first = _first
        self.last  = ''
      elsif @split_name.length == 2
        _first, _last = @split_name
        self.first = _first
        self.last  = _last
      else
        parse_prefix.
          parse_suffix.
          parse_last_name.
          parse_first_name.
          parse_middle_name
      end
    end

    def parse_prefix
      if is_prefix? @split_name.first
        self.prefix = @split_name.shift
      end

      return self
    end

    def parse_suffix
      self.suffix = []
      while is_suffix? @split_name.last
        self.suffix.unshift @split_name.pop
      end
      self.suffix = self.suffix.join(' ')

      return self
    end

    def parse_last_name
      if !is_name_joiner? @split_name[-2]
        self.last = []
        self.last.unshift @split_name.pop

        while is_last_name_prefix?(@split_name.last)
          self.last.unshift @split_name.pop
        end

        self.last = self.last.join(' ')
      end

      return self
    end

    def parse_first_name
      shift_distance = is_name_joiner?(@split_name[1]) ? 3 : 1
      self.first = @split_name.shift(shift_distance).join(' ')

      return self
    end

    def parse_middle_name
      # whatever's left
      self.middle = @split_name.join ' '

      return self
    end

    def initials
      _i = ''
      _i += self.first.slice(0,1)  if !blank?(self.first)
      _i += self.middle.slice(0,1) if !blank?(self.middle)
      _i += self.last.slice(0,1)   if !blank?(self.last)
      _i.upcase
    end

    def to_s
      [
        self.prefix,
        self.first,
        self.middle,
        self.last,
        self.suffix
      ].reject( &method(:blank?) ).join(' ')
    end

  private
    def normalize_and_split
      if @input_string.count(",") > 1
        # this is a thing that I cannot recognize
        @split_name = []
      elsif @input_string.count(",") == 1
        if suffix_follows_comma?(@input_string)
          # remove commas from the split
          @split_name = split_first_middle_last.map {|n| n.gsub(',', '')}
        else
          @split_name = split_last_comma_first_middle
        end
      else
        @split_name = split_first_middle_last
      end

      return self
    end

    # check whether each part is a suffix
    def suffix_follows_comma? name
      name.split(',')[1].split(' ').all? {|part| is_suffix?(part)}
    end

    def split_last_comma_first_middle
      match = @input_string.match(",")
      normalized = ""
      if match
        normalized_first, normalized_last = [match.post_match.strip, match.pre_match.strip]

        # in case suffix follows right side of comma
        split_right_side = normalized_first.split(' ')
        while is_suffix?(split_right_side.last)
          normalized_last += ' ' + split_right_side.pop

          # prune suffix from first name group
          normalized_first = split_right_side.join(' ')
        end
      end
      [normalized_first, normalized_last].map {|n| n.split(" ")}.flatten
    end

    def split_first_middle_last
      @input_string.split(" ")
    end

    def is_prefix?(string)
      is_ix?(PREFIXES, string)
    end

    def is_suffix?(string)
      is_ix?(SUFFIXES, string)
    end

    def is_name_joiner?(string)
      is_ix?(NAME_JOINERS, string)
    end

    def is_last_name_prefix?(string)
      return false if blank?(string)
      LAST_PREFIXES.include?(string.downcase)
    end

    def is_ix?(kind, string)
      return false if blank?(string)
      kind.any? { |k| string =~ /\A#{k}\.?\z/i }
    end

    def blank?(string)
      string.nil? || string == ''
    end

  end
end
