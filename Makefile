SHELL=/bin/bash
DATE:=$(shell date "+%Y%m%d-%H%M%S")

mysql-client:
	cd /home/isucon; mysql isuports

log_rotate/mysql:
	-sudo mv /var/log/mysql/mysql-slow.log ~/log/mysql/mysql-slow-${DATE}.log
	-sudo chmod 666 ~/log/mysql/mysql-slow-${DATE}.log
	cd /home/isucon; mysqladmin flush-logs

log_rotate/nginx:
	-sudo mv /var/log/nginx/access.log ~/log/nginx/${DATE}.log
	-sudo chmod 666 ~/log/nginx/${DATE}.log

show-slowquery/mysql:
	mysqldumpslow `ls -d ~/log/mysql/*|tail -n1`

show-kataribe:
	cat `ls -d ~/log/nginx|tail -n1` | ../tools/kataribe -f kataribe.toml

restart/mysql:
	sudo systemctl restart mysql
	/home/isucon/webapp/sql/prepare.sh
	mysqladmin flush-logs

restart/nginx:
	sudo systemctl restart nginx

restart/docker:
	sudo systemctl daemon-reload
	sudo systemctl restart isuports.service

sync:
	git pull; make restart/docker
