# gmailsmtp
Docker image to send email via gmail account

# Usage
Build with
	./build_gmailsmtp

Run with 
	docker run -d -e user=$gmailaddress -e pass=$gmailpassword -p 25:25 softinnov/gmailsmtp

* -d makes the container run in background (as daemon)
* $gmailadress and $gmailpassword : substitute with your gmail identification
* -p 25:25 map the container port 25 to the server port 25

