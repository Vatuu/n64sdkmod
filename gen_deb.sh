#!/bin/bash

dew_it()
{
    for var in "$@"
    do
        sudo dpkg-deb --build packages/$var
    done
}

echo "Warning: this resets permissions in the packages folder to the current user."

if [ -z $1 ]
    then
        choice="all"
elif [ -n $1 ]
    then
        choice=$1
fi

mkdir -p debs

sudo chown -R root:root ./packages

case $choice in
   "all") dew_it spicy armips ed64log loader64 bass makemask iquesdk n64sdk u64assets root-compatibility-enviroment rsp-tools vadpcm-tools n64-conv-tools n64graphics libkmc libhvqm libnustd libnusys libsndtools n64manual n64-demos nusys-demos n64sdk-common;;
   "spicy") dew_it spicy;;
   "armips") dew_it armips;;
   "ed64log") dew_it ed64log;;
   "loader64") dew_it loader64;;
   "bass") dew_it bass;;
   "makemask") dew_it makemask;;
   "ique") dew_it iquesdk;;
   "n64") dew_it n64sdk;;
   "assets") dew_it u64assets;;
   "demos") dew_it n64-demos;;
   "root") dew_it root-compatibility-enviroment;;
   "rsp") dew_it rsp-tools;;
   "pcm") dew_it vadpcm-tools;;
   "conv") dew_it n64-conv-tools;;
   "n64gfx") dew_it n64graphics;;
   "kmc") dew_it libkmc;;
   "hvqm") dew_it libhvqm;;
   "std") dew_it libnustd;;
   "sndtools") dew_it libsndtools;;
   "nusys") dew_it libnusys;;
   "man") dew_it n64manual;;
   "demos") dew_it n64-demos;;
   "nudemos") dew_it nusys-demos;;
   "common") dew_it n64sdk-common;;
   *) echo "Sorry nothing";;
esac

sudo chown -R $USER:$USER ./packages

mv packages/*.deb debs

if [[ $choice == "all" ]]
    then
        echo "Creating Packages.gz for APT archive"

        cd debs
        dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
        cd ..
fi

