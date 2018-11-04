set -o xtrace
set -e 

CID=`docker ps --filter "name=findlectures_vespa" -q`

docker container prune -f

if [ ! -z $CID ]; then
  docker container kill $CID
fi

docker run -m 10G --detach --name findlectures_vespa --hostname findlectures \
    --rm --privileged --volume `pwd`/app:/app \
    --publish 8080:8080 --publish 19112:19112 vespaengine/vespa

until docker exec findlectures_vespa bash -c 'curl -s --head http://localhost:19071/ApplicationStatus'
do
  :
done

./load.sh
#./wait-for-it.sh -t 120 localhost:8080 -- ./load.sh
