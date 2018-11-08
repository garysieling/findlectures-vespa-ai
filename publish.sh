docker container commit -a "Gary Sieling <gary@garysieling.com>" -m "FindLectures data" findlectures-vespa findlectures-vespa
docker tag findlectures-vespa garysieling/findlectures-vespa:latest
docker push garysieling/findlectures-vespa:latest
