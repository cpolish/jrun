#!/bin/bash

filename=${1##*/}
java_arg=${filename%.java}

mkdir -p /tmp/java

if [[ -f "/tmp/java/$filename" ]]
then
	if cmp -s $1 "/tmp/java/$filename"
	then
		if ! [[ -f "/tmp/java/$java_arg.class" ]]
		then
			javac $1 -d "/tmp/java"
		fi
	else
		cp $1 "/tmp/java/"
		javac $1 -d "/tmp/java"
	fi
else
	cp $1 "/tmp/java"
	javac $1 -d "/tmp/java"
fi

java -cp "/tmp/java" $java_arg ${@:2}
