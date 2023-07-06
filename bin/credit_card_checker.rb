require File.expand_path(File.dirname(__FILE__) + '/..') + '/lib/credit_card'
ARGV ||= []

def usage
  msg=<<-EOF

    An input file wasn't found.
    Usage: ruby <path to credit_card_root>/bin/credit_card_checker.rb /some/path/to/input_file

  EOF
  STDERR.puts msg
  exit -1
end

file =  ARGV[0]
file = File.expand_path(File.dirname(file)) + "/#{File.basename(file)}"
if File.exists?(file)
  File.readlines(file).each { |cc_num|
    info = cc_num.credit_card_info
    valid_text = info[:valid] ? 'valid' : 'invalid'
    printf("%20s%18s (%s)\n", info[:type], cc_num, valid_text)
  }
  exit 0
else
  usage
end
