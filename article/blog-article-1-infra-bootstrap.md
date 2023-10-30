Terraform is a great tool for automating infrastructure configuration.  As your configuration and environemnt grows larger, and additional team members come in to help manage 

Digger.dev is an open-source tool that allows you to run all Terraform processes in the same CI infrastructure you already use. It reuses your CI infrastructure with jobs, logs, compute, orchestration, etc. so it is scalable and secure 1.

To launch a Civo Kubernetes cluster using Digger.dev, you can follow these steps:

- In your Civo account, obtain an API token by going to [Settings -> Profile and clicking the Security tab](https://dashboard.civo.com/security)

- Create a new Github Repository.  

- In the new Github repository, go to Settings -> Secrets and Variables -> Actions.  Create a `CIVO_TOKEN` secret with the API key above

In the repository, create the following files (links provided with example code)

- Create your Terraform configuration

- [core-cluster/provider.tf](https://github.com/ssmiller25/civo-digger/blob/main/core-cluster/provider.tf)
- [core-clutser/cluster.tf](https://github.com/ssmiller25/civo-digger/blob/main/core-cluster/cluster.tf)

- Sketch out the core digger configuraiton

- [.github/workflows/digger.yml](https://github.com/ssmiller25/civo-digger/blob/main/.github/workflows/digger.yml) Main pipeline
- [.digger.yml](https://github.com/ssmiller25/civo-digger/blob/main/digger.yml): Digger confonfiguration itself


Once you have created a new project, you can create a new pipeline by following the instructions here. In the pipeline configuration file, you can specify the Civo cluster configuration using the civo-kubernetes-cluster module. You can find more information about the [civo-kubernetes-cluster module here](https://www.civo.com/docs/kubernetes/create-a-cluster).

After you have created the pipeline configuration file, you can commit it to your repository and push it to your Git provider. Digger.dev will automatically detect the changes and start the pipeline.

Once the pipeline has completed successfully, you can log in to your Civo account and verify that the Kubernetes cluster has been created.

Now that we have a new cluster setup, we can begin building out more production-level services in round 2 of our blog articles