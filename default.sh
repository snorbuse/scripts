#!/bin/sh

#/ Usage: default.sh [OPTION]... [FILE]...
#/ Brief description of this script
#/ Create an alias (alias create-script='cp -n ~/bin/default.sh') in ~/.bashrc to create new scripts.
#/
#/   -h, --help   display this help and exit


# -e, will exit the script if any command returns a non-zero status code
# -u, will prevent using an undefined variable
# -o pipefail,  will force pipelines to fail on the first non-zero status code 
set -euo pipefail

info()  { echo "[INFO]  $*" ; }
error() { echo "[ERROR] $*" ; exit 1 ; }
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
cleanup() { :; }
trap cleanup EXIT


### MAIN BODY OF SCRIPT ###
function main {
  if [ "" = "$NAME" ]; then
    error "You must provide a name, --name"
  fi 

  info "This is the main function, with argument: name=\"$NAME\""
}
### END MAIN BODY ###


# Command/function to run
COMMAND="help"
# Initialize arguments
NAME=""

# Parse arguments
while [[ $# -ge 1 ]]; do
  key="$1"
  case $key in
    -h|--help)
      COMMAND="help"
      shift
    ;;
    -m|--main)
      COMMAND="main"
      shift
    ;;
    -n|--name)
      NAME=$2
      shift
      shift
    ;;
    *)
      echo "$0: unrecognized option '$key'"
      echo "Try '$0 --help' for more information."
      exit -1
    ;;
  esac
done

# Run command/function
case $COMMAND in
  "main")
    main
  ;;
  *|"help")
    usage
  ;;
esac
