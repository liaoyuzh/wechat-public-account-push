#!/bin/bash

COMMON_PATH=~/wechat-public-account-push
INDEX_FILE_PATH="$COMMON_PATH/config/index.cjs"
INDEX_SOURCE_URL="https://gist.githubusercontent.com/liaoyuzh/5d53eb93afbc03d03e3c8aaa830fab2f/raw/8e86209c4033b048d5b37c54671b96f4f353a84e/gistfile1.txt"
CONFIG_SERVER_FILE_PATH="$COMMON_PATH/config/config-server.cjs"
CONFIG_SERVER_SOURCE_URL="https://gist.githubusercontent.com/liaoyuzh/95b108b2f15e16d9dd60092d0772b77a/raw/dc2af2eb4988e7ef358e9ee3ecf44536b1d1f51e/gistfile1.txt"

if [ "$1" == "run" ]; then
    cd "$COMMON_PATH" && npm run pm2start
elif [ "$1" == "stop" ]; then
    pm2 stop "@wechat-push"
elif [ "$1" == "restart" ]; then
    pm2 restart "@wechat-push"
elif [ "$1" == "delete" ]; then
    pm2 delete "@wechat-push"
elif [ "$1" == "log" ]; then
    pm2 log "@wechat-push"
elif [ "$1" == "flush" ]; then
    pm2 flush
elif [ "$1" == "config-index" ]; then
    curl -o "$INDEX_FILE_PATH" "$INDEX_SOURCE_URL"
elif [ "$1" == "config-server" ]; then
    curl -o "$CONFIG_SERVER_FILE_PATH" "$CONFIG_SERVER_SOURCE_URL"
elif [ "$1" == "config-all" ]; then
    curl -o "$INDEX_FILE_PATH" "$INDEX_SOURCE_URL"
    curl -o "$CONFIG_SERVER_FILE_PATH" "$CONFIG_SERVER_SOURCE_URL"
else
    echo "Invalid command. Usage:"
    echo "To run the script: ./script.sh run"
    echo "To stop the service: ./script.sh stop"
    echo "To restart the service: ./script.sh restart"
    echo "To delete the service: ./script.sh delete"
    echo "To view the logs: ./script.sh log"
    echo "To flush the logs: ./script.sh flush"
    echo "To update config index: ./script.sh config-index"
    echo "To update config server: ./script.sh config-server"
    echo "To update both config index and server: ./script.sh config-all"
fi
