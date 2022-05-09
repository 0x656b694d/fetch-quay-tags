#!/bin/sh

IMAGE="$1"
TOKEN="$2"

set -eu

if [ -z "$IMAGE" -o -z "$TOKEN" ]
then
    echo -e "Usage:\n\tdelete-tags.sh REPO/IMAGE BEARER_TOKEN"
    exit 1
fi

shift 2

for tag in "$@"
do
    echo "Deleting $IMAGE:$tag"
    curl -L -H "Authorization: Bearer $TOKEN" -X DELETE "https://quay.io/api/v1/repository/$IMAGE/tag/$tag"
done
