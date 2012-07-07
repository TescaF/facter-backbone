require 'mcollective'

class FactFinder
    extend MCollective::RPC

    def self.find_fact (fact_to_find)
        rpcutil = rpcclient("rpcutil")
    	rpcutil.progress = false
	facts = {}

	rpcutil.get_fact(:fact => fact_to_find) do |resp|
	  begin
	    value = resp[:body][:data][:value]
	    if value
	    	facts.include?(value) ? facts[value] << resp[:senderid] : facts[value] = [ resp[:senderid] ]
            end
      	  rescue Exception => e
            STDERR.puts "Could not parse facts for #{resp[:senderid]}: #{e.class}: #{e}"
      	  end
  	end
    	return fact_to_find, facts
    end

    def self.display_fact (fact_to_display)
	display_text = ""
	fact, facts = find_fact(fact_to_display)

    	display_text = display_text + "Report for fact: #{fact}\n\n"

    	facts.keys.sort.each do |k|
      	  display_text = display_text + "        " + k.to_s() + " found " + facts[k].size.to_s() + " times\n"

          facts[k].sort.each do |f|
            display_text = display_text + "            #{f}\n"
          end
	end
	display_text
    end
end