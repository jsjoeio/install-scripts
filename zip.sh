#!/bin/sh

zip_course() {
 echo "zipping up course..."
 zip -r fake-course.zip fake-course
}

zip_course