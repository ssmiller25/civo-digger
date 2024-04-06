#!/usr/bin/env bash

# Bootstrap digger.  Assuming appropriate environment varibales are set

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)


msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

# REQUIRED enviornment variables and basic sanity checks

if ! command -v "envsubst" &> /dev/null; then
    die "envsubst not found.  Please install the gettext package"
fi

# Build out appropriate kubeconfig, or error out if it doesn't exist
if [ -r "${KUBECONFIGDATA}" ]; then
  TEMPDIR=$(mktemp)
  echo ${KUBECONFIGDATA} > ${TEMPDIR}/.kubeconfig
  export KUBECONFIG=${TEMPDIR}/.kubeconfig
elif [ ! -r "${KUBECONFIG}" ]; then
  die "${KUBECONFIG} is not available to read.  Please set the KUBECONFIG env variables."
fi

if [ -z "${CLUSTERDNS}" ]; then
  die "CLUSTERDNS must be explicitly set as an env variables"}
fi

if [ -z "${EMAILADDR}" ]; then
  die "EMAILADDR must be explicitly set as an env variables"}
fi

if [ -z "${GITHUBORG}" ]; then
  die "GITHUBORG must be explicitly set as an env variables"}
fi

if [ -z "${DBURL}" ]; then
  die "DBURL must be explicitly set as an env variables"}
fi

export RANDOM_AUTH_TOKEN=$(openssl rand -base64 12)
export HTTP_BASIC_AUTH_PW=$(openssl rand -base64 12)