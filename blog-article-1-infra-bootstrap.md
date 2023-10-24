Terraform is a great tool for automating infrastructure configuration.  

Digger.dev is an open-source tool that allows you to run all Terraform processes in the same CI infrastructure you already use. It reuses your CI infrastructure with jobs, logs, compute, orchestration, etc. so it is scalable and secure 1.

To launch a Civo Kubernetes cluster using Digger.dev, you can follow these steps:

First, you need to have a Civo account and the Civo CLI installed. You can sign up for a Civo account here and install the Civo CLI by following the instructions here.

Next, you need to create a new project in Digger.dev and add your Civo API key as a secret. You can do this by following the instructions here.

Once you have created a new project, you can create a new pipeline by following the instructions here. In the pipeline configuration file, you can specify the Civo cluster configuration using the civo-kubernetes-cluster module. You can find more information about the [civo-kubernetes-cluster module here](https://www.civo.com/docs/kubernetes/create-a-cluster).

After you have created the pipeline configuration file, you can commit it to your repository and push it to your Git provider. Digger.dev will automatically detect the changes and start the pipeline.

Once the pipeline has completed successfully, you can log in to your Civo account and verify that the Kubernetes cluster has been created.

Now that we have a new cluster setup, we can begin building out more production-level services in round 2 of our blog articles