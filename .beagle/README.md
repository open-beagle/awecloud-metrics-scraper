# version

<!-- https://github.com/kubernetes-sigs/dashboard-metrics-scraper -->

```bash
git remote add upstream git@github.com:kubernetes-sigs/dashboard-metrics-scraper.git

git fetch upstream

git merge v1.0.8
```

## debug

```bash
# cache
docker run -it --rm \
-v $PWD/:/go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
-w /go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
-e GOPROXY=https://goproxy.cn \
-e GOFLAGS=-mod=vendor \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.19-alpine \
rm -rf vendor && go mod vendor

# build
docker run -it --rm \
-v $PWD/:/go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
-w /go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.19-alpine \
bash .beagle/build.sh

# test
docker run -it --rm \
-v $PWD/:/go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
-w /go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
registry.cn-qingdao.aliyuncs.com/wod/alpine:3 \
./dist/metrics-sidecar-linux-amd64 version
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
  -e DRONE_COMMIT_BRANCH="master" \
  -e PLUGIN_MOUNT="./vendor" \
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
  -e DRONE_COMMIT_BRANCH="master" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
