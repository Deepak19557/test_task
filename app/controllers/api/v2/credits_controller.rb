class Api::V2::CreditsController < ApplicationController
	
	url = URI("https://api.fullcontact.com/v2/person.json?emailrenilraphyp100@gmail.com")
	http = Net::HTTP.new(url.host, url.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Get.new(url)
	request['X-FullContact-APIKey']='uA6TuVzTHWADhBuZYaRND38YTsLgFihx'
	request['requestId'] = 'e158b690-4c96-4542-bd1a-f5a374580156'
	request['Content-Type'] = 'application/json'
	response = http.request(request)
	response = JSON.parse response.body

end


