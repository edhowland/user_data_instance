# user_data_instance
User data is for passing metadata or runtime init scripts to instance creation in cloud services like AWS or Digital Ocean.

## Abstract

## TODO


1. Create SSH keys
 2. Add to Github (public key)
3. Create init script to add to user/.ssh
4. Create user data multipart file
5. Make init script to git clone this repo from GitHub


## Installation

```
  $ sudo apt-get install cloud-init cloud-utils
```n


## Create User Data multipart file

After creating your script to be run one time after instance creation,
and copying your private key to be used for git clone,
you wil need to combine them in a MIME Multipart file. The program to do this is
'write-mime-multipart' supplied in the 'cloud-utils' package in Ubuntu
you installed above.

Here is how to run this:

```

$ cd scripts/
$ ls
first-time.sh
git.rsa
$ write-mime-multipart  first-time.sh  git.rsa  -o data.mp
$ ls
data.mp
first-time.sh
git.rsa
$ 

$ cd scripts/
$ ls
first-time.sh
git.rsa
$ write-mime-multipart  first-time.sh  git.rsa  -o data.mp
$ ls
data.mp
first-time.sh
git.rsa
```


## Embedding MIME multipart in JSON file for curl 

After you have a created a MIME multipart file (E.g. scripts/data.mp in this case),
you can embed it in a .json file:

```
  $ ./embed-mime-json.rb -j input.json -m scriptes/data.mp -o output.json
```






## Modify any key in a JSON file

You can modify any key in a .json file with the 'modify-json.rb'.
It takes a input file, output file and a single key value pair.
You can use it inspect all the keys in the input file with --verbose option.

```
./modify-json.rb  -j input.json  -o output.json -k size -v 256mb --verbose
Before change
size: 512mb
name: ed-userdata
image: ubuntu-14-04-x64
region: sfo1
ssh_keys: 
backups: false
user_data: 
ipv6: false
private_networking: true
After change
size: 256mb
name: ed-userdata
image: ubuntu-14-04-x64
region: sfo1
ssh_keys: 
backups: false
user_data: 
ipv6: false
private_networking: true


$ jq .size input.json ; jq .size output.json 
"512mb"
"256mb"
```
