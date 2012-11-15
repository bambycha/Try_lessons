@var = {:name=>"s", :email=>"s", :feedback=>" "} 
field_bool=[]
@field_all=true
@var.each do |key, value|
	if ((!key)||(value == "")||(value =~ /\s/))
	puts "stop"
			n<<false#return nil
	else
			puts "go"#return 0
			n<<true
	end
end
n.each do |key|
	@before= key && @before
	end
puts @before.to_s