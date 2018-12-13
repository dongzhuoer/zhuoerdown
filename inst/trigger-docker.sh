#!/bin/bash

user=dongzhuoer; repo=docker-rlang; branch=zhuoerdown
curl -s -X POST \
    -H "Authorization:token $TRAVIS_TOKEN" \
    -H "Content-Type:application/json" \
    -H "Accept:application/json" \
    -H "Travis-API-Version:3" \
    -d "{ \"request\":{\"branch\":\"$branch\", \"message\":\"rebuilt $TRAVIS_REPO_SLUG\"} }"  \
    "https://api.travis-ci.com/repo/$user%2F$repo/requests"
