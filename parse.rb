class Parse

	def create_headers(filename)

	if File.exists?(filename)

		return success(filename)

	else
		return failure
		
	end

end #create_headers

	def success(filename)		# Sets headers for succesful case

	headers = []

	body = File.read(filename)

		if filename =~ /\.html/			# =~ returns true or false if regexp
			filetype = "text/html"		# finds ANYTHING like that in string
		elsif filename =~ /\.css/
			filetype = "text/css"
		else
			filetype = "text/plain"
		end

	headers << "HTTP/1.1 200 OK"
	headers << "Content-Type: #{filetype}"


	response = shovel_in(headers, body)
	return(response)

	end # success(filename)

	def failure				# Sets headers for failure case

	headers = []


	body = "File not found!"	# Sets body for failure

	headers << "HTTP/1.1 404 Not Found"
	headers << "Content-type: Text/plain"

	response = shovel_in(headers, body)
	return(response)


	end # failure

	def shovel_in(headers, body)	# Shovels in elements common to both failure and success cases

		headers << "Content-Length: #{body.size}" # Number of characters in body
		headers << "Connection: close" # Msg is finished

		headers = headers.join("\r\n")
		response = [headers, body].join("\r\n\r\n")
		return(response)

	end # shovel_in


end # Parse(filename)