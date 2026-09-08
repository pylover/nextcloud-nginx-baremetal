VER = 0.1.0
TARGETHOST = office
DISTNAME = nextcloud-installer-v$(VER)
DISTFILE = $(DISTNAME).tar.gz
INSTALL = \
	install.sh \
	vars.example \
	README.md
		

dist/$(DISTFILE):
	mkdir -p dist
	tar -cvf $@ --transform='s,^,nextcloud-installer/,' $(INSTALL)


.PHONY: clean
clean::
	rm -rf dist/*


deploy: dist/$(DISTFILE)
	scp dist/$(DISTFILE) $(TARGETHOST):/tmp
	ssh $(TARGETHOST) "tar -xvf /tmp/$(DISTFILE)"
	ssh $(TARGETHOST) "cd /tmp/$(DISTNAME); ./install.sh"
