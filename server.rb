require 'rubygems'
require 'sinatra'
require 'mcollective'
require 'fact_finder'

get '/fact/:factname' do
	ARGV.unshift params[:factname]
	MCollective::Applications.run "facts"
	facts = FactFinder.display_fact params[:factname]
	"#{facts}"
end

get '/all' do
	@facts.map do |k,v|
		"#{k} => #{v}<br>"
	end
end

get '/' do
	"Hi"
end

get '/ping' do
	MCollective::Applications.run "ping"
end

get '/facts' do
	erb :layout
end

__END__
