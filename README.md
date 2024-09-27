The content should be used as an introduction workshop how to use OpenEdge 12 and Docker.
The best would be to have Docker Desktop windows installed to run everything

Starting workshop labs 2 some response.ini file is used.
This file is used to install some OpenEdge products and control codes with expiration date are positioned
Best would be to use your own serial number and expiration date for products on Linux.

If you clone the repository check if your response.ini file has LF as end of line.
If you have CRLF you could get an issue with the proinst step.
Command to avoid such clone issue
 git clone https://github.com/lkieffer2002/pug2024OEDocker.git --config core.autocrlf=false 

When you use a download and unzip it should work also.

