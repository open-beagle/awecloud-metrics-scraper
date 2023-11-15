# version

<!-- https://github.com/kubernetes-sigs/dashboard-metrics-scraper -->

```bash
git remote add upstream git@github.com:kubernetes-sigs/dashboard-metrics-scraper.git

git fetch upstream

git merge v1.0.6
```

## debug

```bash
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
./dist/metrics-sidecar-linux-amd64 --version

docker run -it --rm \
-v $PWD/:/go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
-w /go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
registry.cn-qingdao.aliyuncs.com/wod/alpine:3-arm64 \
./dist/metrics-sidecar-linux-arm64 --version

docker run -it --rm \
-v $PWD/:/go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
-w /go/src/github.com/kubernetes-sigs/dashboard-metrics-scraper \
registry.cn-qingdao.aliyuncs.com/wod/alpine:3-ppc64le \
./dist/metrics-sidecar-linux-ppc64le --version
```
