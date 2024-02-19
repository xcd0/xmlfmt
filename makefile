BIN           := ./xmlfmt.exe
REVISION      := `git rev-parse --short HEAD`
FLAG          :=  -a -tags netgo -trimpath -ldflags='-s -w -extldflags="-static" -buildid='

all:
	cat ./makefile

build:
	rm -rf ./files
	make generate
	make fmt
	go build

release:
	rm -rf ./files
	make generate
	make fmt
	go build $(FLAG)
	make upx 
	@echo Success!

fmt:
	goimports -w *.go
	gofmt -w *.go

generate:
	go generate

upx:
	upx --lzma $(BIN)

