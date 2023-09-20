# python-builder

## 构建

```shell
pack builder create ofnee-python-builder:v0.1.0 --config ./builder.toml
```

你将得到一个 builder 镜像：
- ofnee-python-builder:v0.1.0

## 使用

```shell
cd samples/user-code/
pack build python-user-app:v1.0.0 --path . --builder ofnee-python-builder:v0.1.0 --env FUNCTION_SOURCE=app.py --env FUNCTION_TARGET=user_function
```

你将得到 app 镜像：
- python-user-app:v1.0.0

```shell
docker run --rm -it -e FUNC_CONTEXT='{"name":"ff-python","version":"v1","triggers":{"http":{"port":8080}}}' -p 8080:8080 python-user-app:v1.0.0
```

通过 curl 访问应用：
```shell
~# curl localhost:8080
hello world
```