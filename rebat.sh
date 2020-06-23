#!/bin/bash

# Constants
INDIA_HONME="/data/wwwroot/india"
DEST_DIR="${HOME}/guns"
JAR_FILE="/data/wwwroot/india/guns-vip-main.jar"
TARGET_JS_FILE="BOOT-INF/classes/assets/note/paAppInfo/paAppInfo_edit.js"


function check {
    # Create unzip dest folder
    if [ ! -d $DEST_DIR ]; then
	mkdir $DEST_DIR
    fi

    # Prepare to copy and unzip
    cp $JAR_FILE $DEST_DIR/
    cd $DEST_DIR && jar -xvf $JAR_FILE

    # Start to find
    if grep -q "upload.render" $TARGET_JS_FILE
    then
	if grep -q "var upload = " $TARGET_JS_FILE
	then
	    echo -e "got upload"
	else
	    echo -e "missing upload"
	fi    
    else
	echo -e "no upload here"
    fi

    exit 0
}

function build {
    cd $DEST_DIR
    mv guns-vip-main.jar guns-vip-main.jar.bak && echo -e "back up old file succeed\n"
    cd $DEST_DIR && jar -cfM0 guns-vip-main.jar BOOT-INF META-INF org
}

case $1 in
    check)
	echo -e "start to check\n"
	check
	;;
    build)
	echo -e "start to build\n"
	build
	;;
    *)
	echo -e "unsupport cmd"
	;;
esac

