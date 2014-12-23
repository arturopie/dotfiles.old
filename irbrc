if defined? ActiveRecord
   ActiveRecord::Base.logger = Logger.new(STDOUT)
end

def safe_require(gem)
  require gem
  puts "#{gem} loaded."
rescue LoadError
  puts "Failed requiring #{gem}. Make sure gem is installed."
end

begin
  safe_require 'hirb'

  safe_require 'interactive_editor'

  safe_require 'looksee'

  safe_require 'whats_up/classic'

  # Configure prompt
  IRB.conf[:PROMPT_MODE] = :SIMPLE

  # Enable history
  IRB.conf[:EVAL_HISTORY] = 1000
  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:HISTORY_FILE] = File::expand_path("~/.irbhistory")

  # Make awesome_print the default formatter
  AwesomePrint.irb! if defined? AwesomePrint

  # Enable hirb, disable paging (which fixes looksee output)
  Hirb.enable pager: false if defined? Hirb

  if defined? WhatsUp
    # Fix whats_up for rails console
    blacklist = WhatsUp::MethodFinder.class_variable_get("@@blacklist")
    blacklist += Object.instance_methods
    WhatsUp::MethodFinder.class_variable_set("@@blacklist", blacklist)
  end

  # Predefine hash and array instances for convenience
  H = { bob: 'Marley', mom: 'Barley', gods: 'Harley', chris: 'Farley' }
  A = H.keys
end
