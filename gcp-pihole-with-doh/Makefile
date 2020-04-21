.PHONY: init plan apply destroy

init:
	terraform init

plan:
	../terraform_wrapper.sh --plan

apply:
	../terraform_wrapper.sh --apply

destroy:
	../terraform_wrapper.sh --destroy

ssh:
	ssh centos@dns01.darkwebkittens.xyz -i ~/.ssh/id_ed25519_GCP -L 3141:127.0.0.1:3141 -o VerifyHostKeyDNS=true
