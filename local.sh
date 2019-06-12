#! /bin/sh

#qinstall core extensions/amazon-lambda-resteasy && \
	sam build --debug | tee sam-build.out && \
	sam local start-api #--debug-port 5005


#--event event.json
