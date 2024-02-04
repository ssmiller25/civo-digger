# Infrastructure as Code Using Digger

Terraform is a great tool for automating infrastructure configuration. As your configuration and environment grow larger, and additional team members come in to help manage infrastructure, a better model needs to be in place to help run your Terraform code in a collaborative manner. Many solutions exist in both the open source ([Atlantis](https://www.runatlantis.io/), [tf-controller](https://github.com/weaveworks/tf-controller)) and commercial ([Terraform Cloud](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-sign-up), [Env0](https://www.env0.com/), [Spacelift](https://spacelift.io/)). A solution that came to my attention recently is Digger.

[Digger](https://www.digger.dev/) is an open-source tool that allows you to run all Terraform processes in the same CI infrastructure you already use. It reuses your CI infrastructure with jobs, logs, compute, orchestration, etc., so you can benefit from your existing software deployment methodology.

To launch a Civo Kubernetes cluster using Digger.dev, you can follow these steps:

- In your Civo account, obtain an API token by going to [Settings -> Profile and clicking the Security tab](https://dashboard.civo.com/security).
- Create a new GitHub Repository.
- In the new GitHub repository, go to Settings -> Secrets and Variables -> Actions. Create a `CIVO_TOKEN` secret with the API key above.
- In the New Repository, ensure you enable GitHub Actions, as well as grant the pipeline read and write permissions.
    ![GitHub Workflow Permissions](images/pr_permissions.png)
- In the repository, create the following files (links provided with example code):
    - [core-cluster/provider.tf](https://github.com/ssmiller25/civo-digger/blob/1-infra-bootstrap/core-cluster/provider.tf)
    - [core-cluster/cluster.tf](https://github.com/ssmiller25/civo-digger/blob/1-infra-bootstrap/core-cluster/cluster.tf)
- Sketch out the GitHub Actions pipeline configuration and core Digger configuration:
    - [.github/workflows/digger.yml](https://github.com/ssmiller25/civo-digger/blob/1-infra-bootstrap/.github/workflows/digger.yml) Main pipeline
    - [.digger.yml](https://github.com/ssmiller25/civo-digger/blob/1-infra-bootstrap/digger.yml): Digger confonfiguration itself
- Once everything has been committed to the `main` branch, you'll need to make a PR to actually test the pipeline.  Create a new branch, `initial-commit`.  Make a minor change to any of the terraform in the `core-cluster` directory.  Push up that branch, then create a new PR
- In that PR, write a new comment of `digger plan` to see the actions the terraform code will perform.
    ![First PR](images/first_pr.png)
- Review the output of the plan output.  This will let you, and any peer reviewers, see what infrastructure changes will occur.
    ![PR Terraform Plan](images/pr_terraform_plan.png)
- If the plan looks good, then write a comment of `digger apply`.
    ![PR comment apply](images/pr_comment_on_apply.png)
- On the PR, you will see the results of the Terraform apply.
    ![PR apply complete](images/github_apply_complete.png)
- Once the apply is complete, merge your PR into the main branch.
- Once the pipeline has completed successfully, you can log in to your Civo account and verify that the Kubernetes cluster has been created.
    ![Civo Completed Cluster](images/civo_completed_cluster.png)

Now we have completed our first cluster, provisioned completely from Digger!

This configuration will get you far, but we will explore hardening our pipeline with better state and lock management, all within the Civo architecture!
