# cloud-quickstart-projects ☁️

Projects to set up a quick instance of something using various common cloud providers (AWS, DigitalOcean, Google Cloud, etc).

### Applications
You will need the following installed locally:
* Ansible
* Terraform

### Global Shell Variables
And these are all tweakable, obviously, but I use my shell `rc` files to export the following variables into my shell environment generally, which should all be fairly self-explanatory.

#### AWS
* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_DEFAULT_REGION`

#### CloudFlare
* `CLOUDFLARE_EMAIL`
* `CLOUDFLARE_API_KEY`

#### DigitalOcean
* `DO_OAUTH_TOKEN`
* `DIGITALOCEAN_TOKEN`

#### Google Cloud
* `GOOGLE_CREDENTIALS`
* `GOOGLE_PROJECT`
* `GOOGLE_REGION`
* `GOOGLE_ZONE`

### Usage
These plans and playbooks are intended to give a super quick jumping off point to start deploy web services and similar tools using cloud providers. They're designed to be relatively secure by default but will definitely need some tweaking for production rather than ephemeral use.

These are for my own use rather than public use, but feel free to use them and build on them where you desire. Most of them are specced to run on the free instances provided by the cloud provider in question (Though some will be a challenge - Wordpress' DB isn't happy and sometimes randomly quits on the measly 600MB RAM we get on a GCP `f1-micro` instance, for example).

Most projects can be initialised by entering the Terraform Plan directory inside this directory and using:

```sh
make init
make plan
make apply
```

Projects can be destroyed with:
```sh
make destroy
```

You will notice these are very similar to the Terraform commands `terraform plan`, `terraform apply` etc, and that is no accident. I am essentially using Makefiles here to dynamically pass some useful environment variables to Terraform when we run it.

For connecting to deployed instances with useful SSH options already set, you can use:
```sh
make ssh
```
