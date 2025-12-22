# fetch-script-file-automation
fetch-script-file automation

## Example command to execute in shell

```shell
/home/bitroidprod/scripts/script.sh -p20251912 fetch
```

## Example command to execute in ansible

```yaml
ansible-playbook fetch_script.yml -i server4, -e "REMOTE_USER=bitroidprod" -e "inputdate=20251812"
```
