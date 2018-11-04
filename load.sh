set -o xtrace
set -e 

docker exec findlectures_vespa bash -c \
    '/opt/vespa/bin/vespa-deploy prepare /app/application && \
    /opt/vespa/bin/vespa-deploy activate'

docker exec findlectures_vespa bash -c \
    'java -jar /opt/vespa/lib/jars/vespa-http-client-jar-with-dependencies.jar \
    --verbose --file /app/data.json --host localhost --port 8080'

