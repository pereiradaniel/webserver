require 'socket'                                    # Require socket from Ruby Standard Library (stdlib)
require_relative './parse.rb'

host = 'localhost'
port = 2000

server = TCPServer.open(host, port)                 # Socket to listen to defined host and port
puts "Server started on #{host}:#{port} ..."        # Output to stdout that server started

	loop do                         # Server loops forever
  		client = server.accept  	# Wait for a client to connect. Accept returns a TCPSocket

  		lines = []
  	while (line = client.gets) && !line.chomp.empty?  # Read the request and collect it until it's empty
    	lines << line.chomp		# Shovels each line into lines array
  	end
  	
  	puts lines		# Output the full request to stdout

	filename = lines[0].gsub(/GET \//, '').gsub(/ HTTP\/.*/, '')
	# ^----- Extracts filename from lines array

	response = Parse.new			# Creates a new instance of Parse class
	returned_response = response.create_headers(filename)	# Processes response through create_headers method
  	client.puts(returned_response)	# Sends the processed response to the client
  	client.close                    # Disconnect from the client

end
