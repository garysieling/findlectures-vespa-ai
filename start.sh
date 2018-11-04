set -o xtrace
set -e 

CID=`docker ps --filter "name=findlectures_vespa" -q`

if [ ! -z $CID ]; then
  docker container kill $CID
fi

docker container prune -f

docker run -m 10G --detach --name findlectures_vespa --hostname findlectures \
    --rm --privileged --volume `pwd`/app:/app \
    --publish 8080:8080 --publish 19112:19112 vespaengine/vespa

until docker exec findlectures_vespa bash -c 'curl -s --head http://localhost:19071/ApplicationStatus'
do
  :
done

docker exec findlectures_vespa bash -c \
    '/opt/vespa/bin/vespa-deploy prepare /app/application && \
    /opt/vespa/bin/vespa-deploy activate'

docker exec findlectures_vespa bash -c \
    'java -jar /opt/vespa/lib/jars/vespa-http-client-jar-with-dependencies.jar \
    --verbose --file /app/videos.json --host localhost --port 8080'

