# redmine 2.6.3

redmineはその時、その時でruby等のバージョンが上がりやり方が変わったりするので初期状態を取っておけるのはいいですね。

初めてDockerで構築したコンテナです。

```bash
$ docker pull takara/redmine
$ docker run --name redmine -p 8080:80 takara/redmine bash
```

[Dockerレポジトリ](https://registry.hub.docker.com/u/takara/redmine/)
