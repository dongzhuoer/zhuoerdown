#!/bin/bash

declare r_lib=$HOME/.local/lib/R
declare work_dir=$HOME/.build-bookdown  # it should not be the same as or contained in $TRAVIS_BUILD_DIR

# before_install -------------
git clone --depth 1 $input_git $work_dir/input
mv $TRAVIS_BUILD_DIR/_bookdown_files/ $work_dir/input/$rmd_dir || echo 'cache not available'


# install -------------
    ## create container
docker run -dt -u `id -u`:`id -g` --name zhuoerdown0 -w $HOME -v $work_dir:$work_dir -v $TRAVIS_BUILD_DIR:$TRAVIS_BUILD_DIR -v $r_lib:$r_lib -e GITHUB_PAT=$GITHUB_PAT dongzhuoer/rlang:zhuoerdown 2> /dev/null
    ## add user & group (assuming the image contains no user)
docker exec -u root zhuoerdown0 groupadd `id -gn` -g `id -g`
docker exec -u root zhuoerdown0 useradd $USER -u `id -u` -g `id -g`
    ## custom command
docker exec -u root zhuoerdown0 bash -c "$root_command"
docker exec zhuoerdown0 bash -c "$user_command"
    ## install R packages
docker exec zhuoerdown0 R --slave -e "$install_pkg"


# before_script -------------
mkdir $work_dir/output 


# script  -------------
if [ "$zhuoerdown" = true ]; then
    docker exec -w $work_dir/input zhuoerdown0 R --slave -e "setwd('$rmd_dir'); bookdown::render_book('', zhuoerdown::make_gitbook('$url', '$custom_yaml'), output_dir = '$work_dir/output')"
    docker exec zhuoerdown0 R --slave -e "file.copy(zhuoerdown:::pkg_file('bookdown.css'), '$work_dir/output')"
else
    docker exec -w $work_dir/input zhuoerdown0 R --slave -e "setwd('$rmd_dir'); bookdown::render_book('', output_dir = '$work_dir/output')"
fi
    ## other files
curl -o $work_dir/output/readme.md https://gist.githubusercontent.com/dongzhuoer/c19d456cf8c1bd977a2f7916f61beee8/raw/cc-license.md
    ## deploy to remote Git
git clone --depth 1 $repo_git $work_dir/repo && mv $work_dir/repo/.git $work_dir/output
cd $work_dir/output && git add --all && git commit -m "travis build at `date '+%Y-%m-%d %H:%M:%S'`" --allow-empty && git push -f

# after_success -------------
wget https://raw.githubusercontent.com/dongzhuoer/bookdown.dongzhuoer.com/master/trigger.sh && bash trigger.sh

# before_cache -------------
mv $work_dir/input/$rmd_dir/_bookdown_files $TRAVIS_BUILD_DIR || echo 'cache not available'
