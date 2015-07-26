#!/bin/bash

#
# archive dir には gitのbareなリポジトリをtar xzfで固めたものがある想定。
#

#
function usage(){
  echo "usage..."
  echo "  $0 [option] <target dir> <archive dir>"
  echo "  [option]"
  echo "  -silent : サイレントモード。途中で確認しない。"
}

#
if [ "$1" = "-silent" ] ; then
  silent=y
  shift
fi

#
if [ "$#" -ne 2 ] ; then
  usage
  exit -1
elif [ ! -d "$1" ] || [ ! -d "$2" ] ; then
  usage
  exit -1
fi

#
target_dir=$1
archive_dir=$2

#
echo "Target Directory : $target_dir"
echo "Archive Directory : $archive_dir"

#
if [ "$silent" != "y" ] ; then
  echo -n "RESET local Git Repositories ? [y/n] (default 'n') : "
  read confimation
else
  confimation=y
fi
if [ "$confimation" != "y" ] ; then
  echo "bye."
  exit 0
fi
echo

#
for repo in `ls $target_dir` ; do
  echo "REMOVE $target_dir/$repo ... "
  rm -rf $target_dir/$repo
done
echo

#
for repo in `ls $archive_dir/*git.tgz` ; do 
  echo "EXPAND $repo ..."
  tar xf $repo -C $target_dir
done

exit 0

