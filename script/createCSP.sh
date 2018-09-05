source dxSetENV
artifact_manager -e -gp -i input/versions.xml -o repo/DP/
csmcli import input/system.yml
# csmcli import input/*.yml
csmcli import repo/DP/ --rebase
csmlint 
csmconfig init -d repo/DP/
