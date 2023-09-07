require "strscan"

class Scanner < StringScanner
  class << self
    def new_line = /\R/
    def backslash = /\\/
    def escaped_new_line = /#{backslash}#{new_line}/

    # Comment
    # from Ruby document
    # https://docs.ruby-lang.org/ja/latest/doc/spec=2fregexp.html#absenceop
    #
    def comment = /\/\*(?~\*\/)\*\//
    def single_line_comment =
      /\/\/((?!#{backslash}|#{new_line}).|#{escaped_new_line})*#{new_line}/

    # Blank
    #
    def b_char = /[ \t]/
    def blank = /#{b_char}|#{comment}|#{single_line_comment}/

    # C11 (https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf)
    #
    # A.1 Lexical grammar
    #
    # A.1.1 Lexical elements
    #
    def token = /
        #{keyword} |
        #{constant} |
        #{string_literal} |
        #{identifier} |
        #{header_name} |
        #{punctuator}
    /x

    # A.1.2 Keywords
    #
    def keywords = %w(
      auto            if              unsigned
      break           inline          void
      case            int             volatile
      char            long            while
      const           register        _Alignas
      continue        restrict        _Alignof
      default         return          _Atomic
      do              short           _Bool
      double          signed          _Complex
      else            sizeof          _Generic
      enum            static          _Imaginary
      extern          struct          _Noreturn
      float           switch          _Static_assert
      for             typedef         _Thread_local
      goto            union
    )
    def keyword = /(#{ keywords.join("|") })/

    # A.1.3 Identifiers
    #
    def identifier = /#{identifier_nondigit}(#{identifier_nondigit}|#{digit})*/
    def identifier_nondigit = /#{nondigit}|#{universal_character_name}/
    def nondigit = /[_a-zA-Z]/
    def digit = /\d/

    # A.1.4 Universal character names
    #
    def universal_character_name = /#{backslash}[uU]#{hex_quad}{1,2}/
    def hex_quad = /#{hexadecimal_digit}{4}/

    # A.1.5 Constants
    #
    def constant = /
      #{floating_constant} |
      #{integer_constant} |
      #{character_constant}
    /x

    # Integer constant
    #
    def integer_constant = /
      #{decimal_constant}#{integer_suffix}? |
      #{hexadecimal_constant}#{integer_suffix}? |
      #{octal_constant}#{integer_suffix}?
    /x
    def decimal_constant = /#{nonzero_digit}#{digit}*/
    def octal_constant = /0#{octal_digit}*/
    def hexadecimal_constant = /#{hexadecimal_prefix}#{hexadecimal_digit}+/
    def hexadecimal_prefix = /0x|0X/
    def nonzero_digit = /[1-9]/
    def octal_digit = /[0-7]/
    def hexadecimal_digit = /\h/
    def integer_suffix = /
      #{unsigned_suffix}#{long_suffix}? |
      #{unsigned_suffix}#{long_long_suffix} |
      #{long_suffix}#{unsigned_suffix}? |
      #{long_long_suffix}#{unsigned_suffix}?
    /x
    def unsigned_suffix = /[uU]/
    def long_suffix = /[lL]/
    def long_long_suffix = /ll|LL/

    # Floating constant
    #
    def floating_constant = /
      #{decimal_floating_constant} |
      #{hexadecimal_floating_constant}
    /x
    def decimal_floating_constant = /
      #{fractional_constant}#{exponent_part}?#{floating_suffix}? |
      #{digit_sequence}#{exponent_part}#{floating_suffix}?
    /x
    def hexadecimal_floating_constant = /
      #{hexadecimal_prefix}#{hexadecimal_fractional_constant}#{binary_exponent_part}#{floating_suffix}?|
      #{hexadecimal_prefix}#{hexadecimal_digit_sequence}#{binary_exponent_part}#{floating_suffix}?
    /x
    def exponent_part = /[eE]#{sign}?#{digit_sequence}/
    def sign = /[+-]/
    def digit_sequence = /#{digit}+/
    def fractional_constant =
      /#{digit_sequence}?\.#{digit_sequence}|#{digit_sequence}\./
    def hexadecimal_fractional_constant = /
      #{hexadecimal_digit_sequence}?\.#{hexadecimal_digit_sequence} |
      #{hexadecimal_digit_sequence}\.
    /x
    def binary_exponent_part = /[pP]#{sign}?#{digit_sequence}/
    def hexadecimal_digit_sequence = /#{hexadecimal_digit}+/
    def floating_suffix = /[flFL]/

    # Enumeration constant
    #
    # enumeration-constant: identifier

    # Character constant
    #
    def character_constant = /(L|u|U)?'#{c_char_sequence}'/
    def c_char_sequence = /#{c_char}+/
    def _any_member_for_c = /(?!'|#{backslash}|#{new_line})./
    def c_char = /#{_any_member_for_c}|#{escape_sequence}/
    def escape_sequence = /
      #{simple_escape_sequence}|
      #{octal_escape_sequence}|
      #{hexadecimal_escape_sequence}|
      #{universal_character_name}
    /x
    def _simple_escape_sequence =
      %w(' " ? \\ a b f n r t v).map { |s| /#{backslash}#{Regexp.quote(s)}/ }
    def simple_escape_sequence = /(#{ _simple_escape_sequence.join("|") })/
    def octal_escape_sequence = /#{backslash}#{octal_digit}{1,3}/
    def hexadecimal_escape_sequence = /#{backslash}x#{hexadecimal_digit}+/

    # A.1.6 String literals
    #
    def string_literal = /#{encoding_prefix}?\"#{s_char_sequence}?\"/
    def encoding_prefix = /u8|u|U|L/
    def s_char_sequence = /#{s_char}+/
    def _any_member_for_s = /(?!"|#{backslash}|#{new_line})./
    def s_char = /#{_any_member_for_s}|#{escape_sequence}/

    # A.1.7 Punctuators
    #
    def symbols = %w"! # % & ( ) * + , - . / : ; < = > ? [ ] ^ { | } ~"
    def punctuator = /#{ symbols.map { |s| Regexp.quote(s) }.join("|") }/

    # A.1.8 Header names
    #
    def header_name = /<#{h_char_sequence}>|"#{q_char_sequence}"/
    def h_char_sequence = /{#h_char}+/
    def h_char = /(?!#{new_line}|>)./ # except the new-line character and >
    def q_char_sequence = /#{q_char}+/
    def q_char = /(?!#{new_line}|")./ # except the new-line character and "

    # A.1.9 Preprocessing numbers
    #
    # pp_number = //

    # A.3 Preprocessing directives
    #
    def pp_keywords = %w(
      if ifdef ifndef elif else endif include define undef line error pragma
    ).sort_by(&:size).reverse
    def pp_keyword = /#{ pp_keywords.join("|") }/
  end

  ESCAPED_NEW_LINE = escaped_new_line
  NEW_LINE = new_line
  NEW_LINES = /(#{ESCAPED_NEW_LINE}|#{NEW_LINE})+/
  BLANK = blank
  BLANKS = /(#{ESCAPED_NEW_LINE}|#{BLANK})+/
  PP_KEYWORD = pp_keyword
  TOKEN = token
  KEYWORD = keyword

  def pp?(s = nil)
    return unless beginning_of_line?
    if s
      scan(/#{BLANK}*##{BLANK}*#{s}/)
    else
      scan(/#{BLANK}*##{BLANK}*#{PP_KEYWORD}/)
    end
  end
  def blank? = scan(BLANKS)
  def new_line? = scan(NEW_LINES)
  def token?(s = nil)
    if s
      scan(/^#{Regexp.quote(s)}/)
    else
      pp? || scan(TOKEN)
    end
  end
  def keyword?(s = nil)
    if s
      match?(KEYWORD) && scan(/^#{Regexp.quote(s)}/)
    else
      scan(KEYWORD)
    end
  end
  def literal? = scan(Scanner.constant) || scan(Scanner.string_literal)
  def next
    raise StopIteration if eos?
    raise "stopped!" unless blank? || new_line? || token?
    matched
  end
end
