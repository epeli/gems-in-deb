
prefix = /usr/local
install_dir = /var/lib/myapp

build:
	bundle install --deployment

test:
	bundle exec ruby test.rb

clean:
	rm -rfv .bundle vendor

install-dirs:
	mkdir -p $(DESTDIR)$(install_dir)

clean-test:
	bundle install --deployment --without test
	bundle clean

install: clean-test install-dirs
	cp -a server.rb Gemfile Gemfile.lock .bundle vendor $(DESTDIR)$(install_dir)

deb:
	dpkg-buildpackage -us -uc

clean-deb:
	rm ../myapp_*.changes
	rm ../myapp_*.deb
	rm ../myapp_*.dsc
	rm ../myapp_*.tar.gz
