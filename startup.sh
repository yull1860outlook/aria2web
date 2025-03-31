#!/bin/bash
set -e
apt install -y jq 

./trojan/trojan-x64 -c ./trojan/config.json &

./aria2/aria2c --conf-path ./aria2/aria2.conf &

/app/alist/alist server --data /app/alist/data &

#"nginx","-c","/etc/nginx/nginx.conf","-g","daemon off;","./trojan","-c","config.json"
cp /app/nginx/localhost.conf /etc/nginx/conf.d/localhost.conf

#----------------------
#x-ui setup
#ln -s /app/x-ui /usr/local/x-ui
#ln -s /app/x-ui /etc/x-ui

export XUI_LOG_LEVEL=info
export XUI_DB_FOLDER=/home 
export XUI_BIN_FOLDER=/app/x-ui/bin
export XUI_LOG_FOLDER=/app/x-ui

#/app/x-ui/x-ui setting -reset
#/app/x-ui/x-ui setting -username admin -password EaeXBwRE
#/app/x-ui/x-ui setting -port 5001
#/app/x-ui/x-ui setting -webBasePath /park-aca/
cp /app/x-ui/x-ui.db /home/x-ui.db

/app/x-ui/x-ui &
#XUI_DEBUG	boolean	false
#XUI_BIN_FOLDER	string	"bin"
#---------------------

exec nginx -c /etc/nginx/nginx.conf 


