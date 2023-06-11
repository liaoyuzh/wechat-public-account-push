#!/bin/bash

COMMON_PATH=~/wechat-public-account-push
CONFIG_SERVER_FILE_PATH="$COMMON_PATH/config/config-server.js"
INDEX_FILE_PATH="$COMMON_PATH/config/index.cjs"

INDEX_SOURCE_URL="https://gist.githubusercontent.com/liaoyuzh/5d53eb93afbc03d03e3c8aaa830fab2f/raw/8e86209c4033b048d5b37c54671b96f4f353a84e/gistfile1.txt"
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
elif [ "$1" == "show-server-config" ]; then
    cat "$CONFIG_SERVER_FILE_PATH"
elif [ "$1" == "update" ]; then
    if [ -n "$2" ]; then
        HOURS=${2%%:*}
        MINUTES=${2#*:}
        SCHEDULE="0 $MINUTES $HOURS * * *"
        echo "// 此时间为每天的 $HOURS:$MINUTES ，*为匹配任意一个" > "$CONFIG_SERVER_FILE_PATH"
        echo "// 这里的时间是中国时间 秒 分 时 日 月 年" >> "$CONFIG_SERVER_FILE_PATH"
        echo "const cornTime = '$SCHEDULE'" >> "$CONFIG_SERVER_FILE_PATH"
        echo "export default cornTime" >> "$CONFIG_SERVER_FILE_PATH"
	echo "Updated $CONFIG_SERVER_FILE_PATH with the schedule: $HOURS:$MINUTES"
	# Commit and push the changes
        git -C "$COMMON_PATH" add "$CONFIG_SERVER_FILE_PATH"
        git -C "$COMMON_PATH" commit -m "Update time to $HOURS:$MINUTES"
        git -C "$COMMON_PATH" push

    else
        echo "Please provide the time in the format HH:MM."
    fi
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
    echo "To update server-config.cjs: ./script.sh update HH:MM"
fi

