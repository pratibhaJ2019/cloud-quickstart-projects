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
	ssh ubuntu@wp02.darkwebkittens.xyz -i ~/.ssh/id_ed25519_GCP
