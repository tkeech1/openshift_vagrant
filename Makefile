up:
	vagrant up

destroy:
	vagrant destroy -f

ssh:
	vagrant ssh master1

gpg-key:
	gpg2 --gen-key

gpg-list:
	gpg2 --list-keys

gpg-publickey-export:
	gpg2 --armor --export --output public_key.gpg EMAIL_ADDRESS
