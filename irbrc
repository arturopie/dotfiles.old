if defined? ActiveRecord
   ActiveRecord::Base.logger = Logger.new(STDOUT)
end

begin
  require 'awesome_print'
  require 'active_support/all'
#  require 'clipboard'
  require 'hirb'
  require 'interactive_editor'
  require 'looksee'
  require 'whats_up/classic'

  # Configure prompt
  IRB.conf[:PROMPT_MODE] = :SIMPLE

  # Enable history
  IRB.conf[:EVAL_HISTORY] = 1000
  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:HISTORY_FILE] = File::expand_path("~/.irbhistory")

  # Make awesome_print the default formatter
  AwesomePrint.irb!

  # Enable hirb, disable paging (which fixes looksee output)
  Hirb.enable pager: false

  # Fix whats_up for rails console
  blacklist = WhatsUp::MethodFinder.class_variable_get("@@blacklist")
  blacklist += Object.instance_methods
  WhatsUp::MethodFinder.class_variable_set("@@blacklist", blacklist)

  # Predefine hash and array instances for convenience
  H = { bob: 'Marley', mom: 'Barley', gods: 'Harley', chris: 'Farley' }
  A = H.keys
#rescue Exception
end