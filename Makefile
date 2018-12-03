SERVICE_NAME=ioc-procserv

.PHONY: install cert

install:
	pip3 install -r requirements.txt
	cp --preserve=mode ${SERVICE_NAME}.service /etc/systemd/system/${SERVICE_NAME}.service
	systemctl daemon-reload
	systemctl enable ${SERVICE_NAME}.service
	systemctl start ${SERVICE_NAME}.service
