docker-aria2
============

Build
-----

To build the image use:

`docker build -t aria2:lastest --no-cache -f Dockerfile .`

Test
----

To test download is working:

`docker run -it aria2:lastest aria2c --conf-path="/etc/aria2/aria2.conf" http://websitetips.com/articles/copy/lorem/ipsum.txt`

Docker-compose
----

A docker-compose example usage :

```
  aria2:
    # image name in docker hub
    image: flyersweb/aria2
    # name on local machine
    container_name: aria2
    # should restart on errors
    restart: always
    # define an owner for downloaded file
    environment:
      - FUID=1003
      - FGID=1003
    volumes:
      # finished downloads
      - /tmp/Download:/dataComplete
      # on going downloads
      - /tmp/OnDownload:/data
      # override with local config
      - ./config/aria2:/etc/aria2
    # for RPC communication you should open this port
    ports:
      - "6800:6800"
```
