#!/bin/bash

#clean app log

sExecCurrentDir=$(cd "$(dirname "$0")"; /bin/pwd)
sExecRootDir=`/bin/readlink -f $sExecCurrentDir/`

source $sExecRootDir'/inc/initial.sh'

sCleanPattern=$1;

if [ -z $sCleanPattern ]; then
    showError 'We need clean pattern.'
else
    showInfo 'We will clean app log. Pattern is '$sCleanPattern
fi

$sDeployServer='all_servers'

_sYamlParam="sDeployServer=$sDeployServer sDeployUser=$sDeployUser sDeleteRootDir=$sAppRootDir’/php-release sDeletePattern=$sCleanPattern"
$sExecAnsiblePlaybook -v -i "$sExecRootDir"/hosts -e "$_sYamlParam" "$sExecRootDir"/yaml/find_delete_dir.yaml