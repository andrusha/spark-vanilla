# Dockerized Spark in vanilla flavour

Dockerized Spark, nothing added, nothing removed, just plain binaries as provided by Apache to base your complex deployment on.

This project is split into three parts:
* `base` - Apache Spark with Hadoop running on OpenJDK-8. 
* `master` - runs master instance.
* `worker` - runs one slave instance `SPARK_MASTER` env variable has to be provided.

## Usage

To build all images do:

```bash
make build
```

Or manually:

```bash
docker build -t andrusha/spark-vanilla:base base
docker build -t andrusha/spark-vanilla:master master
docker build -t andrusha/spark-vanilla:worker worker
```

### Kubernetes

If you use `minikube` for development do:

```bash
make minikube
```

And use your images like normal:

```yaml
apiVersion: apps/v1beta1
kind: Deployment
spec:
  replicas: 1
    spec:
      containers:
      - name: spark-master
        image: andrusha/spark-vanilla:master
        ports:
        - containerPort: 6066
        - containerPort: 7077
        - containerPort: 8080
        env:
        - name: SPARK_MASTER_PORT
          value: "7077"
```

In conjunction with:
```yaml
apiVersion: apps/v1beta1
kind: Deployment
spec:
  replicas: 1
  template:
    spec:
      containers:
      - name: spark-worker
        image: andrusha/spark-vanilla:worker
        ports:
        - containerPort: 8081
        env:
        - name: SPARK_MASTER
          value: spark-master:7077
        - name: SPARK_WORKER_PORT
          value: "17077"
```