SHELL := /bin/bash
TARGETS = ihparse

# http://docs.travis-ci.com/user/languages/go/#Default-Test-Script
test:
	go get -d && go test -v

imports:
	goimports -w .

fmt:
	go fmt ./...

all: fmt test
	go build

install:
	go install

clean:
	go clean
	rm -f coverage.out
	rm -f $(TARGETS)
	rm -f ihparse-*.x86_64.rpm
	rm -f debian/ihparse*.deb
	rm -rf debian/ihparse/usr

cover:
	go get -d && go test -v	-coverprofile=coverage.out
	go tool cover -html=coverage.out

ihparse:
	go build cmd/ihparse/ihparse.go

# ==== packaging

deb: $(TARGETS)
	mkdir -p debian/ihparse/usr/sbin
	cp $(TARGETS) debian/ihparse/usr/sbin
	cd debian && fakeroot dpkg-deb --build ihparse .

REPOPATH = /usr/share/nginx/html/repo/CentOS/6/x86_64

publish: rpm
	cp ihparse-*.rpm $(REPOPATH)
	createrepo $(REPOPATH)

rpm: $(TARGETS)
	mkdir -p $(HOME)/rpmbuild/{BUILD,SOURCES,SPECS,RPMS}
	cp ./packaging/ihparse.spec $(HOME)/rpmbuild/SPECS
	cp $(TARGETS) $(HOME)/rpmbuild/BUILD
	./packaging/buildrpm.sh ihparse
	cp $(HOME)/rpmbuild/RPMS/x86_64/ihparse*.rpm .
