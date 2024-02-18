# Hardening our Infrastructure as Code Pipeline with Digger

In [Part 1](blog-article-1-infra-bootstrap.md) of our blog series, we setup a simple Digger pipeline to perform infrastructure as code (IaC) deployments all withing a Github pipeline.  But what if we wanted to expand such a deployment for a larger installation, or want it hardened for production deployments.  We will look at deploying the [Orchestrator Backend](https://docs.digger.dev/readme/howitworks)

## The Orchestrator Backend

The Orchestrator Backend is a service that triggers Pipeline Runs.  Most CI pipeline runs are usually triggered by events within the source code management system - code commits, pull requests, and other internal activity.  Most CI systems also provide a way for CI activities to be triggered externally.  And that is what the Digger Orchestrator uses to help build a configuration that will work more efficently with multiple users and larger enviornments.

- Quicker response to PR comments and faster status check updates
- Paralellzation where appropriate  
- Appropriate queing with multiple PRs
- PR Level locks

## Prep Our Core Cluster

Given that we have are initial workflwo already build out, we can use Digger itself to deploy the Digger orchestrator on Civo architecture!

First, let's make sure we have Ingress and Cert Manager working.  Adjust the firewall to allow incoming 80 and 443 connections, and add cert-manager

_cluster.tf adjustments_

Now, let's get DNS setup.  We will leverage civo dns architecture to provision a domain for use with our cluster.  We will also provision a wildcard TLS cert that we can use across the applicatios in our cluster

_dns.tf which will provision dns_
_ingress.tf Work, which will include setup of cert-mnaager_

Use our terraform pipeline to deploy

_screenshot of successful cluster deploy_

Make sure DNS zone SOA records are setup to properly point to child domain.  Let's verify that cert-manager is appropratily configured

_Check on cert manager_

## Deploy Digger in Terraform!





## Commercial Support

[Source](https://docs.digger.dev/self-host/deploy-binary)

## Terraform Shared State

Refer to existing Civo blog article

