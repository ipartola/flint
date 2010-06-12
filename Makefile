all:
clean:

install:
	mkdir -p $(DESTDIR)/usr/sbin/
	install -m 755 flint $(DESTDIR)/usr/sbin/

