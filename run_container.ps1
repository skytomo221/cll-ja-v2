#!/bin/bash

# 注意！これは使い物になりません。

# Try podman, and then docker.  If sudo or something is required,
# the user should make a script named either "podman" or "docker"
# that is in their path first and has whatever they need; we're
# going to stop trying to do it for them.
# 
if (![string]::IsNullOrEmpty($(where.exe podman 2>$null))) {
  $CONTAINER_BIN='podman'
} elseif (![string]::IsNullOrEmpty($(where.exe docker 2>$null))) {
  $CONTAINER_BIN='docker'
} else {
  Write-Output "I can't get a working container system.  You need to either have podman (preferred) or docker installed and running for this build system to work.  I have tried both \"podman info\" and \"docker info\", with and without sudo."
  exit 1  
}


# Manually pull any -a or -A arguments so we can use them to build
# volume-sharing options into our container run call.  This assumes
# arguments are well-formed; *shrug*
$args = @("$@")
$extra_vols = @()
$extra_dirs = @()
$args | ForEach-Object {$index = 0} {
  if ("$_" -eq '-a' -or "$_" -eq '-A') {
    $nextarg="$args[$index+1]"
    $nextargfile="/tmp/$(echo "$(args[$index+1])" | tr -c 'a-zA-Z0-9-' '_' | sed -e 's/^_*//' -e 's/_*$//' )"
    $extra_vols += @("-v", "${nextarg}:${nextargfile}")
    $extra_dirs += @("$nextarg")
    $args[$index+1] = "$nextargfile"
  }
  $index++
}

Invoke-Expression "$CONTAINER_BIN kill cll_build" 2>$null
Invoke-Expression "$CONTAINER_BIN rm cll_build" 2>$null

$dir = "/$(Convert-Path .)".Replace(":", "").Replace("\", "/");

# FOR TESTING; forces complete container rebuild
# $CONTAINER_BIN build --no-cache -t lojban/cll_build -f Dockerfile .
# $CONTAINER_BIN rmi lojban/cll_build
$TmpFile = New-TemporaryFile
Write-Output "Running container image build; this may take a while."
Write-Output `n
if ($?) {
  Invoke-Expression "$CONTAINER_BIN build -t lojban/cll_build -f Dockerfile ." 2>$TmpFile
} else {
  Write-Output "Container image build failed.  Here's the output: "
  Write-Output `n
  Get-Content $TmpFile
  Write-Output `n
  Write-Output `n
  Write-Output "Container image build failed.  Output is above."
  Write-Output `n
  Write-Output `n
  Remove-Item -f $TmpFile
  exit 1
}

Remove-Item -Path $TmpFile

# ここまでしか動くことを確認していません
Write-Output "$CONTAINER_BIN run --rm --name cll_ja_build -v ${dir}:/srv/cll ${extra_vols[@]} -it lojban/cll_ja_build /bin/bash -c `"cd /srv/cll ; ./cll_build ${args[*]}`""
exit 1

Invoke-Expression "$CONTAINER_BIN run --rm --name cll_ja_build -v ${dir}:/srv/cll ${extra_vols[@]} -it lojban/cll_ja_build /bin/bash -c `"cd /srv/cll ; ./cll_build ${args[*]}`""
