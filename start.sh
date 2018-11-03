set -o xtrace
set -e 

docker run -m 10G --detach --name vespa --hostname vespa-tutorial \
    --privileged --volume `pwd`:/app \
    --publish 8080:8080 --publish 19112:19112 vespaengine/vespa

docker exec vespa bash -c '/opt/vespa/bin/vespa-deploy prepare /app/application && \
    /opt/vespa/bin/vespa-deploy activate'

docker exec vespa bash -c 'java -jar /opt/vespa/lib/jars/vespa-http-client-jar-with-dependencies.jar \
    --verbose --file /app/data.json --host localhost --port 8080'

