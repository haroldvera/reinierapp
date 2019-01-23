make build-docker
docker tag reinierapp gcr.io/reinier-cloud/reinierapp
gcloud docker -- push gcr.io/reinier-cloud/reinierapp
