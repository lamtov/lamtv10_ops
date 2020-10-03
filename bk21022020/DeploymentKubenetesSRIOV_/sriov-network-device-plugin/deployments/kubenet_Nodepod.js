apiVersion: apps/v1
kind: Deployment
metadata:
  name: vconfig
  labels:
    app: vconfig
spec:
  replicas: 1
  selector:
    matchLabels:
      app: vconfig
  template:
    metadata:
      labels:
        app: vconfig
    spec:
      containers:
      - name: vconfig
        image: docker-registry:5000/vconfig:v1.7
        ports:
        - containerPort: 8000
---
apiVersion: v1
kind: Service
metadata:
  name: vconfig
  labels:
    app: vconfig
spec:
  type: NodePort
  ports:
    - port: 8000
      targetPort: 8000
      nodePort: 8000
  selector:
    app: vconfig



-------------------------------------------------------
vi mongodb.yaml 
  994  vi mongodb-service.yaml 

apiVersion: v1
kind: Service
metadata:
  name: db
  labels:
    name: mongo
    app: manoapp
spec:
  selector:
    name: mongo
  type: ClusterIP
  ports:
    - name: db
      port: 27017
      targetPort: 27017



  995  kubectl apply -f mongodb.yaml 
  996  kubectl apply -f mongodb-service.yaml.yaml 
  997  kubectl apply -f mongodb-service.yaml
  998  kubectl get pods
  999  kubectl get service

*--------------------------------------------------------------

apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongodb-mano
  labels:
    appdb: mongodb-mano
spec:
  replicas: 1
  selector:
    matchLabels:
      appdb: mongodb-mano
  template:
    metadata:
      labels:
        appdb: mongodb-mano
    spec:
      containers:
        - name: mongodb-mano
          image: docker-registry:5000/mongo
          ports:
            - containerPort: 27017
---
apiVersion: v1
kind: Service
metadata:
  name: mongodb-mano
  labels:
    app: mongodb-mano
spec:
  type: NodePort
  ports:
    - port: 27017
      targetPort: 27017
      nodePort: 27017
      protocol: TCP
  selector:
    appdb: mongodb-mano

