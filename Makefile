SHELL=/bin/bash
DATE:=$(shell date "+%Y%m%d-%H%M%S")

mysql-client:
	cd /home/isucon; mysql isuports

log_rotate/mysql:
	-sudo mv /var/log/mysql/mysql-slow.log ~/log/mysql/mysql-slow-${DATE}.log
	-sudo chmod 666 ~/log/mysql/mysql-slow-${DATE}.log
	cd /home/isucon; mysqladmin flush-logs

restart/docker:
	sudo systemctl daemon-reload
	sudo systemctl restart isuports.service
