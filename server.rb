require 'rubygems'
require 'sinatra'
require 'mcollective'
require 'fact_finder'

get '/fact/:factname' do
	facts = FactFinder.display_fact params[:factname]
	"#{facts}"
end

get '/all' do
	@facts.map do |k,v|
		"#{k} => #{v}<br>"
	end
end

get '/facts' do
	erb :layout
end

__END__
