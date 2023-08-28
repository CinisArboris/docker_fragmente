docker rm -f c.web_diogenes_rage

docker build -t i.web_diogenes_rage .

docker run --name=c.web_diogenes_rage -p 80:1337 i.web_diogenes_rage
