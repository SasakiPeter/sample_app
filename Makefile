.PHONY: deploy-start
deploy-start:
	heroku maintenance:on --app sample-app-a0d475e5-516d-d832
	heroku pg:reset DATABASE --app sample-app-a0d475e5-516d-d832 --confirm sample-app-a0d475e5-516d-d832

.PHONY: deploy-finish
deploy-finish:
	heroku maintenance:off --app sample-app-a0d475e5-516d-d832
