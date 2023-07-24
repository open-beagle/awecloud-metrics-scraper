# version

<!-- https://github.com/kubernetes-sigs/dashboard-metrics-scraper -->

```bash
git remote add upstream git@github.com:kubernetes-sigs/dashboard-metrics-scraper.git

git fetch upstream

git merge v1.0.9
```

## debug

```bash
# vendor
docker run -it --rm \
-v $PWD/:/go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
-w /go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.20 \
rm -rf vendor && go mod vendor

# build
docker run -it --rm \
-v $PWD/:/go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
-w /go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.20 \
bash .beagle/build.sh

# test
docker run -it --rm \
-v $PWD/:/go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
-w /go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
registry.cn-qingdao.aliyuncs.com/wod/alpine:3-amd64 \
./dist/metrics-sidecar-linux-amd64 version

docker run -it --rm \
-v $PWD/:/go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
-w /go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
registry.cn-qingdao.aliyuncs.com/wod/alpine:3-arm64 \
./dist/metrics-sidecar-linux-arm64 version

docker run -it --rm \
-v $PWD/:/go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
-w /go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
registry.cn-qingdao.aliyuncs.com/wod/alpine:3-ppc64le \
./dist/metrics-sidecar-linux-ppc64le version
```

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="awecloud-metrics-scraper" \
  -e PLUGIN_MOUNT="./.git,./vendor" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="awecloud-metrics-scraper" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
