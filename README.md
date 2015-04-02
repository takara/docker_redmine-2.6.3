# redmine 2.6.3

redmineはその時、その時でruby等のバージョンが上がりやり方が変わったりするので初期状態を取っておけるのはいいですね。

初めてDockerで構築したコンテナです。

## 使用する
```bash
$ docker pull takara/redmine
$ docker run -itv --name redmine -p 8080:80 takara/redmine bash
```

dockerの動いているサーバーへ`http://<server>:8080`へアクセスすればredmineのトップ画面が表示される。


## イメージを作成
```bash
$ git clone https://github.com/takara/docker_redmine-2.6.3.git
$ cd docker_redmine-2.6.3
$ docer build -t <image_name> .
```

[Dockerレポジトリ](https://registry.hub.docker.com/u/takara/redmine/)
