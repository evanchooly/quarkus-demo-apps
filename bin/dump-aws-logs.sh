#! /bin/sh

COMMAND=${COMMAND:-sam}

cleanUp() {
	echo $1 | sed -e 's/\[/\\[/g' -e 's/\]/\\]/g' -e 's/\$/\\$/g' -e 's/"//g'
}

events() {
	NAME=$1
	echo
	mkdir -p target

  cat << EOF > target/log.sh
aws logs get-log-events \\
     --log-group-name /aws/lambda/${LOG_GROUP} \\
     --log-stream-name $NAME \\
     | jq '.events[].message' | sed -e 's|\\\\n||g' -e 's/^"//' -e 's/"$//' -e 's/\\\t/ /g'
EOF
	LOGFILE=target/$( echo ${NAME}.log | cut -d \] -f2 )
	echo Getting events for $NAME in to $LOGFILE
  sh target/log.sh > $LOGFILE
  rm -f target/log.sh
}

names() {
  aws logs describe-log-streams --log-group-name /aws/lambda/${LOG_GROUP} | \
    jq '.logStreams[].logStreamName'
}

dump() {
  names | while read NAME
  do
      events "$( cleanUp $NAME )"
  done
}

clearStreams() {
  aws logs create-log-group \
      --log-group-name /aws/lambda/${LOG_GROUP} 2>/dev/null || true
  mkdir -p target

  names | while read NAME
      do
          NAME=$( cleanUp $NAME )
          cat << EOF > target/log.sh
aws logs delete-log-stream --log-group-name /aws/lambda/${LOG_GROUP} --log-stream-name $NAME
EOF

    sh target/log.sh
    rm -f "target/$( echo ${NAME}.log | cut -d \] -f2 )"

  done
}