.PHONY: init plan apply destroy

init:
	terraform init

plan:
	export TF_VAR_AWS_PUBKEY="~/.ssh/id_rsa_AWS.pub" && \
	export TF_VAR_AWS_PRIVKEY="~/.ssh/id_rsa_AWS" && \
	export TF_VAR_MY_PUBLIC_IP="$(shell curl --silent -4 http://ipecho.net/plain)/32" && \
	export TF_VAR_DESIRED_HOSTNAME="jitsi" && \
	terraform plan

apply:
	export TF_VAR_AWS_PUBKEY="~/.ssh/id_rsa_AWS.pub" && \
	export TF_VAR_AWS_PRIVKEY="~/.ssh/id_rsa_AWS" && \
	export TF_VAR_MY_PUBLIC_IP="$(shell curl --silent -4 http://ipecho.net/plain)/32" && \
	export TF_VAR_DESIRED_HOSTNAME="jitsi" && \
	terraform apply

destroy:
	export TF_VAR_AWS_PUBKEY="~/.ssh/id_rsa_AWS.pub" && \
	export TF_VAR_AWS_PRIVKEY="~/.ssh/id_rsa_AWS" && \
	export TF_VAR_MY_PUBLIC_IP="$(shell curl --silent -4 http://ipecho.net/plain)/32" && \
	export TF_VAR_DESIRED_HOSTNAME="jitsi" && \
	terraform destroy

ssh:
	ssh ubuntu@jitsi.alexhaydock.co.uk -i ~/.ssh/id_rsa_AWS
