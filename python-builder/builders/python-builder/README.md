# python-builder

## 构建

```shell
pack builder create ofnee-python-builder:v0.1.0 --config ./builder.toml
```

## 使用

```shell
cd samples/user-code/
pack build python-user-app:v1.0.0 --path . --builder ofnee-python-builder:v0.1.0 --env FUNCTION_NAME=my-func
```

```shell
docker run -it --rm -p 8080:8080 python-user-app:v1.0.0
```