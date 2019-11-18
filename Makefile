.PHONY: show-help
# See <https://gist.github.com/klmr/575726c7e05d8780505a> for explanation.
## This help screen
show-help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)";echo;sed -ne"/^## /{h;s/.*//;:d" -e"H;n;s/^## //;td" -e"s/:.*//;G;s/\\n## /---/;s/\\n/ /g;p;}" ${MAKEFILE_LIST}|LC_ALL='C' sort -f|awk -F --- -v n=$$(tput cols) -v i=29 -v a="$$(tput setaf 6)" -v z="$$(tput sgr0)" '{printf"%s%*s%s ",a,-i,$$1,z;m=split($$2,w," ");l=n-i;for(j=1;j<=m;j++){l-=length(w[j])+1;if(l<= 0){l=n-i-length(w[j])-1;printf"\n%*s ",-i," ";}printf"%s ",w[j];}printf"\n";}'

.PHONY: build
## Build the binary
build:
	env GOOS=linux go build -ldflags="-s -w" -o ./bin/icebreakerbot ./icebreakerbot/main.go

.PHONY: clean
## Delete built binaries
clean:
	rm -rf ./bin

.PHONY: deploy
## Deploy binary
deploy: clean build
	npx serverless deploy --verbose

.PHONY: test
## Run tests
test:
	gofmt -d ./icebreakerbot
	go test ./icebreakerbot
	go vet ./icebreakerbot

.PHONY: fmt
## Format and fix what can be fixed automatically
fmt:
	go fmt ./icebreakerbot
	go fix ./icebreakerbot

.PHONY: apply-initial-terraform
## Apply initial terraform
apply-initial-terraform:
	AWS_DEFAULT_REGION=us-east-1 terragrunt apply -var aws_default_region=us-east-1
