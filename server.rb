require 'sinatra'
require 'facter'

before do
	@facts = Facter.to_hash
	@factlist = @facts.keys
end

get '/fact/:factname' do
	fact_name = params[:factname]
	if !@factlist.include?(fact_name)
		"#{fact_name} is not a fact name. <p> You must select one of the following: <br>#{@factlist}"
	else	
		"#{params[:factname]} => #{@facts[params[:factname]]}"
	end
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
