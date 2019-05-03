#! /bin/sh

qinstall core extensions/amazon-lambda-resteasy && \
	sam build --debug | tee sam-build.out && \
	sam local invoke --event event.json
