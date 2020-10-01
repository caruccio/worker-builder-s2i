s2i-builder:
	docker build . -t caruccio/worker-builder-s2i:latest
	docker push caruccio/worker-builder-s2i:latest
