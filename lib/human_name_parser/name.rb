module HumanNameParser
  class Name
    PREFIXES = ['mr', 'ms', 'miss', 'mrs', 'sir', 'prof', 'professor', 'md', 'dr']
    SUFFIXES = ['esq','esquire','jr','sr','2','ii','iii','iv', 'v', 'phd', 'md', 'do', 'dc', 'dds']
    LAST_PREFIXES = ['al', 'bar','ben','bin','da','dal','de la', 'de', 'del', 'der', 'di', 'el', 'ibn', 'la', 'le', 'mc', 'san', 'st', 'ste', 'van', 'van der', 'van den', 'vel','von']

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
        self.first = _firstjk
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
      self.last = []
      self.last.unshift @split_name.pop

      while is_last_name_prefix?(@split_name.last)
        self.last.unshift @split_name.pop
      end

      self.last = self.last.join(' ')

      return self
    end

    def parse_first_name
      self.first = @split_name.shift || ''

      return self
    end

    def parse_middle_name
      # whatever's left
      self.middle = @split_name.join ' '

      return self
    end

    def initials
      _i = ''
      _i += self.first.slice(0,1)  if self.first && self.first.length > 0
      _i += self.middle.slice(0,1) if self.middle && self.middle.length > 0
      _i += self.last.slice(0,1)   if self.last && self.last.length > 0
      _i.upcase
    end

    def to_s
      [
        self.prefix,
        self.first,
        self.middle,
        self.last,
        self.suffix
      ].reject {|n| n.length == 0}.join(' ')
    end

  private
    def normalize_and_split
      if @input_string.count(",") > 1
        # this is a thing that I cannot recognize
        @split_name = []
      elsif @input_string.count(",") == 1
        @split_name = split_last_comma_first_middle
      else
        @split_name = split_first_middle_last
      end

      return self
    end

    def split_last_comma_first_middle
      match = @input_string.match(",")
      normalized = ""
      if match
        normalized = [match.post_match.strip, match.pre_match.strip].join(" ")
      end
      normalized.split(" ")
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

    def is_last_name_prefix?(string)
      return false if string.nil? || string == ""
      LAST_PREFIXES.any? { |p| string.downcase.match(/^#{p}$/) }
    end

    def is_ix?(kind, string)
      return false if string.nil? || string == ""
      kind.any? {|k| string.downcase.match(/^#{k}\.?$/)}
    end

  end
end
