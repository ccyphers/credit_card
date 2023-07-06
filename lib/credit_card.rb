module CreditCardTypes
  AMEX = Proc.new { |i|
    res = 'Unknown'
    begin
      i.gsub!(/ /, '')
      sub_str = i[0..1]
      res = 'AMEX' if sub_str == '34' or sub_str == '37' and i.length == 15
    rescue => e
      puts "EE: #{e.inspect}"
    end
    res
  }

  DISCOVER = Proc.new { |i|
    res = 'Unknown'
    begin
      i.gsub!(/ /, '')
      res = 'Discover' if i[0..3] == '6011' and i.length == 16
    rescue
      puts "EE: #{e.inspect}"
    end
    res
  }

  MASTERCARD = Proc.new { |i|
    res = 'Unknown'
    begin
      i.gsub!(/ /, '')
      res = 'MasterCard' if i[0..1].to_i.between?(51, 55) and i.length == 16
    rescue
      puts "EE: #{e.inspect}"
    end
    res
  }

  VISA = Proc.new { |i|
    res = 'Unknown'
    begin
      i.gsub!(/ /, '')
      res = 'VISA' if i[0] == '4' and (i.length == 13 or i.length == 16)
    rescue
      puts "EE: #{e.inspect}"
    end
    res
  }

end

class CreditCard
  class <<self
    def details(num)
      self.new(num).info
    end

  end

  def initialize(num)
    raise ArgumentError, "CC Num missing for CreditCard#initialize" unless num.kind_of?(String)
    @cc_num = num
  end

  def is_amex?

  end

  def valid_checksum?
    index = @cc_num.length-1
    ct = 1
    sum = 0
    while index > -1
      i = @cc_num[index].to_i
      if ct.even?
        i = i * 2
        if i > 9
          tmp = "#{i}"
          i = 0
          tmp.each_char { |char|
            i += char.to_i
          }
        end
      end
      sum += i
      index -= 1
      ct += 1
    end
    sum % 10 == 0
  end

  def type
    [CreditCardTypes::AMEX, CreditCardTypes::DISCOVER, CreditCardTypes::MASTERCARD, CreditCardTypes::VISA].each { |type|
      tmp = type.call(@cc_num)
      return tmp unless tmp == 'Unknown'
    }
    'Unknown'
  end

  def info
    res = {:type => type, :valid => false}
    res[:valid] = valid_checksum? unless res[:type] == 'Unknown'
    res
  end
end

class String
  def credit_card_info
    self.gsub!(/[\r|\n]/, '')
    CreditCard.details(self)
  end
end
