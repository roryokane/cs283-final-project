# encoding: utf-8

require 'sinatra'
require 'optparse'
require 'memoist'
require_relative 'convert'
require_relative 'config_loader'

extend Memoist
CONFIG = ConfigLoader.new.config_for("server")


def options
	defaults = CONFIG['default options']
	options = defaults
	
	OptionParser.new do |opt|
		opt.banner = "Usage: server [OPTS]"
		opt.on('-p', '--port N', Numeric, 'Port to listen on.', "Default: #{defaults[:port]}") { |p| options[:port] = p }
		opt.parse!(ARGV)
	end
	
	options
end
memoize :options


configure do
	set :port, options[:port]
end

get '/convert' do
	input = request.body.string
	convert_bc_to_c(input)
end
