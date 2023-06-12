import os
import subprocess
from datetime import datetime, timedelta

COMMON_PATH = os.path.expanduser("~/wechat-public-account-push")
INDEX_FILE_PATH = os.path.join(COMMON_PATH, "config", "index.cjs")
INDEX_SOURCE_URL = "https://gist.githubusercontent.com/liaoyuzh/5d53eb93afbc03d03e3c8aaa830fab2f/raw/8e86209c4033b048d5b37c54671b96f4f353a84e/gistfile1.txt"
CONFIG_SERVER_FILE_PATH = os.path.join(COMMON_PATH, "config", "server-config.js")
CONFIG_SERVER_SOURCE_URL = "https://gist.githubusercontent.com/liaoyuzh/95b108b2f15e16d9dd60092d0772b77a/raw/dc2af2eb4988e7ef358e9ee3ecf44536b1d1f51e/gistfile1.txt"

def run_command(command):
    try:
        if command == "run":
            os.chdir(COMMON_PATH)
            os.system("npm run pm2start")
        elif command == "stop":
            os.system("pm2 stop '@wechat-push'")
        elif command == "restart":
            os.system("pm2 restart '@wechat-push'")
        elif command == "delete":
            os.system("pm2 delete '@wechat-push'")
        elif command == "log":
            os.system("pm2 log '@wechat-push'")
        elif command == "flush":
            os.system("pm2 flush")
        elif command == "show":
            run_command("show-server-config")
        elif command == "flush-restart-log" or command == "rerun":
            run_command("flush")
            run_command("restart")
            run_command("log")
        elif command == "config-index":
            os.system(f"curl -o {INDEX_FILE_PATH} {INDEX_SOURCE_URL}")
        elif command == "config-server":
            os.system(f"curl -o {CONFIG_SERVER_FILE_PATH} {CONFIG_SERVER_SOURCE_URL}")
        elif command == "config-all":
            os.system(f"curl -o {INDEX_FILE_PATH} {INDEX_SOURCE_URL}")
            os.system(f"curl -o {CONFIG_SERVER_FILE_PATH} {CONFIG_SERVER_SOURCE_URL}")
        elif command.startswith("update"):
            parts = command.split()
            if len(parts) == 2:
                time = parts[1]
                hours, minutes = time.split(":")
                current_time = datetime.utcnow()
                converted_time = current_time.replace(hour=int(hours), minute=int(minutes)) - timedelta(hours=8)
                converted_hours = str(converted_time.hour).zfill(2)
                converted_minutes = str(converted_time.minute).zfill(2)
                schedule = f"0 {converted_minutes} {converted_hours} * * *"
                with open(CONFIG_SERVER_FILE_PATH, "w") as file:
                    file.write("// 此时间为每天的 {}:{} ，*为匹配任意一个\n".format(converted_hours, converted_minutes))
                    file.write("// 这里的时间是中国时间 秒 分 时 日 月 年\n")
                    file.write(f"const cronTime = '{schedule}'\n")
                    file.write("export default cronTime\n")
                print("Updated {} with the schedule: {}:{}".format(CONFIG_SERVER_FILE_PATH, converted_hours, converted_minutes))
                # Commit and push the changes
                subprocess.run(["git", "-C", COMMON_PATH, "add", CONFIG_SERVER_FILE_PATH])
                subprocess.run(["git", "-C", COMMON_PATH, "commit", "-m", f"Update time to {converted_hours}:{converted_minutes}"])
                subprocess.run(["git", "-C", COMMON_PATH, "push"])
            else:
                print("Please provide the time in the format HH:MM.")
        elif command == "show-server-config":
            with open(CONFIG_SERVER_FILE_PATH, "r") as file:
                contents = file.read()
                print(contents)
        else:
            print("Invalid command. Usage:")
            print("To run the script: run")
            print("To stop the service: stop")
            print("To restart the service: restart")
            print("To delete the service: delete")
            print("To view the logs: log")
            print("To flush the logs: flush")
            print("To update config index: config-index")
            print("To update config server: config-server")
            print("To update both config index and server: config-all")
            print("To update server-config.cjs: update HH:MM")
    except Exception as e:
        print(f"An error occurred: {str(e)}")

def main():
    while True:
        command = input("Enter a command (or 'quit' to exit): ")
        if command == "quit" or command == "q":
            break
        run_command(command)

if __name__ == "__main__":
    main()
