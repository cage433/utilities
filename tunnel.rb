#!/bin/ruby -w

require 'optparse'
require 'ostruct'

class Options 
  def self.parse(args)
    options = OpenStruct.new
    
    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: tunnel.rb [options]"

      opts.separator ""
      opts.separator "Specific options:"

      # Mandatory argument.
      opts.on("-p", "--port <port number>",
              "Port to open forward tunnel on") do |port|
        options.port = port
      end
    end

  end
end
