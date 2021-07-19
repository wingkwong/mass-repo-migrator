#!/usr/bin/env bash

###################################################################
#Script Name    : migrate.sh                                                                                             
#Description    : Migrate N git repositories from X to Y in just Z clicks                                                                                
#Args           : N/A                                                                                          
#Author         : wingkwong                              
#Email          : wingkwong.code@gmail.com                                        
###################################################################

#  _____________________________________
# |                                     |  
# |          I hope it works            |
# |_____________________________________|
#      ||
#      ||
#       \                    / \  //\
#        \    |\___/|      /   \//  \\
#             /0  0  \__  /    //  | \ \    
#            /     /  \/_/    //   |  \  \  
#            @_^_@'/   \/_   //    |   \   \ 
#            //_^_/     \/_ //     |    \    \
#         ( //) |        \///      |     \     \
#       ( / /) _|_ /   )  //       |      \     _\
#     ( // /) '/,_ _ _/  ( ; -.    |    _ _\.-~        .-~~~^-.
#   (( / / )) ,-{        _      `-.|.-~-.           .~         `.
#  (( // / ))  '/\      /                 ~-. _ .-~      .-~^-.  \
#  (( /// ))      `.   {            }                   /      \  \
#   (( / ))     .----~-.\        \-'                 .~         \  `. \^-.
#              ///.----..>        \             _ -~             `.  ^-`  ^-_
#                ///-._ _ _ _ _ _ _}^ - - - - ~                     ~-- ,.-~
#                                                                   /.-~

# list of source repositories
source_repositories=(
  # example: bitbucket as source
  "https://bitbucket.org/foo/repo1.git"
  "https://bitbucket.org/foo/repo2.git"
  "https://bitbucket.org/foo/repo3.git"
  "https://bitbucket.org/foo/repo4.git"
)

# list of target repositories
target_repositories=(
  # example: AWS CodeCommit as target
  "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/repo1"
  "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/repo2"
  "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/repo3"
  "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/repo4"
)

# check if git has been installed
if ! command -v git &> /dev/null; then
    printf "[ERROR] git is not installed or not in the PATH\n"
    exit
fi

# check if both array length matches
source_repositories_len=${#source_repositories[@]}
target_repositories_len=${#target_repositories[@]}
if [ "$source_repositories_len" -ne  "$target_repositories_len" ]; then
  printf '[ERROR] source repositories contain %s items while target repositories contain %s items\n' "$source_repositories_len" "$target_repositories_len"
  exit
fi

for i in "${!source_repositories[@]}"; do
  {
    original_directory=$(pwd)
    source=${source_repositories[i]}
    target=${target_repositories[i]}
    last_segment="${source##*/}"
    repository_directory="${last_segment%.git}.git"
    printf "Cloning source repository %s\n" "${source}" 
    git clone --mirror "$source" &&
    cd $repository_directory &&
    printf "Pushing to target repository %s\n" "${target}" &&
    git remote set-url --push origin "$target" &&
    git push --mirror &&
    cd ..
  } || 
  {
    printf "[ERROR] Failed to migrate from %s to %s. Skipping ...\n" "$source" "$target"
    # in case something goes wrong after the directory was changed
    current_directory=$(pwd)
    if [ "$current_directory" != "$original_directory" ]; then
        cd ..
    fi
  }
done
