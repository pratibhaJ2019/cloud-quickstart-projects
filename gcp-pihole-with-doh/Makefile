.PHONY: init plan apply destroy

init:
	terraform init

plan:
	export TF_VAR_GCP_PUBKEY="~/.ssh/id_ed25519_GCP.pub" && \
	export TF_VAR_GCP_PRIVKEY="~/.ssh/id_ed25519_GCP" && \
	export TF_VAR_MY_PUBLIC_IP="$(shell curl --silent -4 http://ipecho.net/plain)/32" && \
	export TF_VAR_DESIRED_HOSTNAME="dns" && \
	terraform plan

apply:
	export TF_VAR_GCP_PUBKEY="~/.ssh/id_ed25519_GCP.pub" && \
	export TF_VAR_GCP_PRIVKEY="~/.ssh/id_ed25519_GCP" && \
	export TF_VAR_MY_PUBLIC_IP="$(shell curl --silent -4 http://ipecho.net/plain)/32" && \
	export TF_VAR_DESIRED_HOSTNAME="dns" && \
	terraform apply

destroy:
	export TF_VAR_GCP_PUBKEY="~/.ssh/id_ed25519_GCP.pub" && \
	export TF_VAR_GCP_PRIVKEY="~/.ssh/id_ed25519_GCP" && \
	export TF_VAR_MY_PUBLIC_IP="$(shell curl --silent -4 http://ipecho.net/plain)/32" && \
	export TF_VAR_DESIRED_HOSTNAME="dns" && \
	terraform destroy

ssh:
	ssh ubuntu@dns.darkwebkittens.xyz -i ~/.ssh/id_ed25519_GCP
