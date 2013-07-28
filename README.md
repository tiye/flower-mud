
Flower-mud is a command line that serves pages
------

I used to place my code at a Nginx server and code to see the HTML page.
Now I think it would be much better to serve with Node,
since now I put code at my home directory and I want a better UI.

### Usage

```bash
npm install -g flower-mud
```

`cd` to your directory of repos, run `flower-mud`, visit http://localhost:3100

### Using this togather with Nginx

config a site like this:

```nginx
upstream flower-mud {
  server 127.0.0.1:3100;
}

server {
  listen 0.0.0.0:80;
  server_name flower-mud;

  location / {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header X-NginX-Proxy true;

    proxy_pass http://flower-mud/;
    proxy_redirect off;
  }
 }
 ```

in `/etc/hosts`, point

```hosts
127.0.0.1 localhost flower-mud
```

add config to `nginx.conf` to enable Nginx visiting your $HOME:

```nginx
user you-account-name your-group-name;
```

### an alternative

Usually I use a static site to show HTML as pages with configs:

```nginx
server {
  listen 80;
  server_name dev;
  root /Users/chen/Code/;
  autoindex on;
  index off;

  location ~ /\.git {
    deny all;
  }
}
```

it works well, but I hope there's better interface.
That's why I started this project.

### Demo

Got a ScreenShot here: ![ScreeShot][shot]

[shot]: https://lh6.googleusercontent.com/-7mf_kmBc_W0/UfUioirjEAI/AAAAAAAAA78/H1AGgI5U2c4/w677-h565-no/mud.png

### License

MIT