# Hardening our Infrastructure as Code Pipeline with Digger

In [Part 1](blog-article-1-infra-bootstrap.md) of our blog series, we setup a simple Digger pipeline to perform infrastructure as code (IaC) deployments all withing a Github pipeline.  But what if we wanted to expand such a deployment for a larger installation, or want it hardened for production deployments.  We will explore several expansions in order to harden our current IaC pipeline, with Digger, in order to provide a full production experience.

## Locks - Oh My

Both Terraform and Digger can leverage DyanmoDB to provide a locking mechanism in order to prevent symotanious execution.  However, what if we wanted to maintain a cloud agnostic architecture.  In order to do that, we are going to look at deploy two complimentary technolgoies - Localstack, and local Github runners.

[Localstack](https://github.com/localstack/localstack) is a simulator for a wide variety of AWS services.  For our purposes, we will be using it to provide a virtual DynamoDB service for lock configuration

Local github runners will be used to run Digger within our architecture.  As we'd rather not expose our localstack installation to the wider internet, we instead will bring the instance running digger into the same Civo Kubernetes cluster running localstack.

## Localstack Buildout

## Github Runner Builtout

## Terraform Shared State

Refer to existing Civo blog article

