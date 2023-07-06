require 'rspec'
require File.expand_path(File.dirname(__FILE__) + '/..') + '/lib/credit_card'

# since the logic to determine if a credit cart type is valid is straight
# forward the chances that additional corner case test would find any bugs is
# next to NIL so a more robust set of scenarios isn't provided.  Scenarios with
# spaces are just to ensure that spaces are removed before determining if the
# type is valid.  In general in most cases input can come from users which can
# include spaces.  It would also be good to expand the code to remove other
# characters besides numbers from the input as well, but for this overview
# we are going to assume these aspects have been removed before we process the
# validations
describe "Credit Card Types" do
  credit_cards = [
                   # mastercards scenarios
                   {:num => '5011111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '5111111111111111', :expected => 'MasterCard', :obj => CreditCardTypes::MASTERCARD},
                   {:num => ' 511111    1111111111     ', :expected => 'MasterCard', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '5211111111111111', :expected => 'MasterCard', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '5311111111111111', :expected => 'MasterCard', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '5411111111111111', :expected => 'MasterCard', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '5511111111111111', :expected => 'MasterCard', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '501111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '511111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '521111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '531111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '541111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '551111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '50111111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '51111111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '52111111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '53111111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '54111111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},
                   {:num => '55111111111111111', :expected => 'Unknown', :obj => CreditCardTypes::MASTERCARD},

                   # AMEX scenarios
                   {:num => '3 4111 111           111111 1   ', :expected => 'AMEX', :obj => CreditCardTypes::AMEX},
                   {:num => '341111111111111', :expected => 'AMEX', :obj => CreditCardTypes::AMEX},
                   {:num => '371111111111111', :expected => 'AMEX', :obj => CreditCardTypes::AMEX},
                   {:num => '34111111111111', :expected => 'Unknown', :obj => CreditCardTypes::AMEX},
                   {:num => '37111111111111', :expected => 'Unknown', :obj => CreditCardTypes::AMEX},
                   {:num => '3411111111111111', :expected => 'Unknown', :obj => CreditCardTypes::AMEX},
                   {:num => '3711111111111111', :expected => 'Unknown', :obj => CreditCardTypes::AMEX},

                   # Discover scenarios
                   {:num => '60    11111111111111', :expected => 'Discover', :obj => CreditCardTypes::DISCOVER},
                   {:num => '6011111111111111', :expected => 'Discover', :obj => CreditCardTypes::DISCOVER},
                   {:num => '6012111111111111', :expected => 'Unknown', :obj => CreditCardTypes::DISCOVER},
                   {:num => '60111111111111111', :expected => 'Unknown', :obj => CreditCardTypes::DISCOVER},
                   {:num => '601111111111111', :expected => 'Unknown', :obj => CreditCardTypes::DISCOVER},


                   # Visa scenarios
                   {:num => '41111111111        11', :expected => 'VISA', :obj => CreditCardTypes::VISA},
                   {:num => '4111111111111', :expected => 'VISA', :obj => CreditCardTypes::VISA},
                   {:num => '41111111111111', :expected => 'Unknown', :obj => CreditCardTypes::VISA},
                   {:num => '411111111111111', :expected => 'Unknown', :obj => CreditCardTypes::VISA},
                   {:num => '4111111111111111', :expected => 'VISA', :obj => CreditCardTypes::VISA},
                   {:num => '3111111111111', :expected => 'Unknown', :obj => CreditCardTypes::VISA},
                   {:num => '3111111111111111', :expected => 'Unknown', :obj => CreditCardTypes::VISA}

  ]

  credit_cards.each { |cc|
    #tmp = cc[:obj].send(:call, cc[:num])
    #puts tmp
    cc[:obj].send(:call, cc[:num]).should == cc[:expected]
  }
end

describe "Validate Credit Card Numbers" do
  it "given a string perform basic validation rule checking" do

    cc_s = [
             {:num => '4111111111111111', :expected => true, :type => 'VISA'},
             {:num => '4111111111111', :expected => false, :type => 'VISA'},
             {:num => '4012888888881881', :expected => true, :type => 'VISA'},
             {:num => '378282246310005', :expected => true, :type => 'AMEX'},
             {:num => '6011111111111117', :expected => true, :type => 'Discover'},
             {:num => '5105105105105100', :expected => true, :type => 'MasterCard'},
             {:num => '5105 1051 0510 5106', :expected => false, :type => 'MasterCard'},
             {:num => '9111111111111111', :expected => false, :type => 'Unknown'}
          ]
    cc_s.each { |cc|
      info = cc[:num].credit_card_info
      info[:valid].should == cc[:expected]
      info[:type].should == cc[:type]
    }
  end
end
