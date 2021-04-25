#!/bin/sh

zip_course() {
 echo "zipping up course..."
 cd fake-course; zip -r ../fake-course.zip *
}

zip_course