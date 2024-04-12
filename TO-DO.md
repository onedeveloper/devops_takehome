# IaC - NOTES
<!-- 
In the project, you will see a `terraform` folder. We want you to create the needed open tofu
code to create the necessary infrastructure to host a small application. The requirements to run
this application are as follows:

- Must run in AWS
- Must have an ECR instance with a docker repository for our `demo_app`
- Must run in an ECS Fargate environment
    - The application needs to be reachable from the outside world
    - The application must have an auto-scalable policy
    - Need to revert to the previous version if the latest version fails to deploy properly
- Must have an aurora-pgsql database
    - The database should not be accessible from the outside world
- A list of Vention members must have read access to the AWS project, except IAM and
    billing policies. Vention members should only be allowed to view things, not modify or
    add new AWS services.
    - jonathan.ducharme@vention.cc
    - max.windisch@vention.cc 
-->

Currently, this project is able to deploy to AWS, the basic parts. -- please view the README inside the terraform/stack directory for ussage.

ECR is succesfully provisioned with terrafom
**TODO**: Review the policy to make sure it actually ensures that the repository is indeed restricted to the account.
**TODO**: ECS needs a cluster, farcgate uses ECS tasks since it is serverless. still pending
**TODO**: ECS Fargate instances need to be placed behind a loadbalancer in the public subnets.
**TODO**: Investigate how can we automate reverting previos version of the application.
      THOUGTS: wouldnt this be a very edge case? the CI/CD pipeline and the review environment should ensure no bad version makes it to production.
**TODO**: Finish creating module to properly provision postgreSQL aurora. Currently is half-baked.
**TODO**: Investigate how to automate creating users since terraform and aws does not allow for automatic user registration. Possible path, create a lambda funtion to automate that operation seeing that terraform is unable to send the email with the credentials ( it wont trigger aws email sending )
**TODO**: Test policies to restrict users are actually working.
**TODO**: Change state to be stored on a centralized registry ( S3, Vault, etc )

# CI/CD
<!-- 
In the project, you will see a folder demo_app. Your task here is to create a CI/CD pipeline to test our demo_app, create a docker image and push that image to an AWS ECR repository.

This is left intentionally vague, so you must understand what is in this demo_app and what is required to have the most efficient CI/CD pipeline.

- Create a feature branch workflow
- Each commit to the feature branch must run the CI pipeline
- Each commit to the feature branch should create a review environment if the CI pipeline succeeds
- Each merge to main should run the CI pipeline and CD pipeline
    - CD pipeline should generate a docker image with the latest tag and an associated version tag 
-->

**TODO**: Dockerize the demo_app
**TODO**: Write all github actions for both application and terraform code.
## BASIC OUTLINE

Here's a brief overview of the tasks needed to set up a CI/CD pipeline using GitHub Actions:

1. **Create a feature branch workflow**: This involves setting up a Git workflow where each new feature or bug fix is developed on a separate branch. This can be enforced through a combination of team discipline and GitHub settings (like branch protection rules).

2. **Set up the CI pipeline**: Create a new GitHub Actions workflow file (e.g., `.github/workflows/ci.yml`). This workflow should be triggered on each push to any feature branch. The workflow should include steps to check out the code, set up the necessary environment (like Node.js or Python), and run your tests.

3. **Create a review environment on successful CI**: This could be a new step in your CI workflow that is only run if the previous steps (your tests) succeed. The specifics of this step depend on your application and where you want to host these review environments. For example, you could deploy the application to a platform like Heroku or AWS, or even spin up a new Docker container. In Vention particular case, probably does not make sense to provision and tear-down a review environment each single time. We could have the actions here deploy to the existing review environment.

4. **Set up the CD pipeline**: Create another GitHub Actions workflow file (e.g., `.github/workflows/cd.yml`). This workflow should be triggered on each push to the main branch. The workflow should include steps to check out the code, build a Docker image, and push it to a Docker registry. You should tag this image with both `latest` and the current version of your application. I have reservations regarding the latest tag as this usually brings issues. I would feel more confortable setting the repository to IMMUTABLE and ensuring the deployments are done for specific tags. Tags should never be overwritten. having the latest tag forces us to run the repository as MUTABLE.

5. **Versioning**: Implement a system for versioning your application. This could be as simple as manually updating a version number in your package.json file, or you could use a tool like `npm version` or `semantic-release` to automate this process.

6. **Documentation**: Document the workflow and how to use it in your project's README file. This should include instructions on how to create a feature branch, how to trigger the CI pipeline, and what to expect when code is merged into the main branch.

The specifics of these tasks will depend on the programming language and framework you're using, we probably will need different tasks for terraform and demo_app ( `.github/workflows/terraform_cd.yml` and `.github/workflows/app_cd.yml` ).

Each of these steps need to be detailed to make sense. They are very high-level and need to be explored in more detail. As an example a more detailed plan for setting up the Continuous Integration (CI) pipeline for a Node.js application using GitHub Actions would follow (in general terms) the following plan:
**NOTE**: Please excuse the code examples as they where taken or adapted from the documentation. they might be complete nonsense as i have not worked with github actions before

1. **Create a new workflow file**: In your repository, create a new file at `.github/workflows/ci.yml`. 

2. **Define the trigger for the workflow**: At the top of the `ci.yml` file, specify that this workflow should run on each push to any branch except the main branch. This can be done with the `on` keyword:

    ```yaml
    on:
      push:
        branches-ignore:
          - 'main'
    ```

3. **Define the jobs for the workflow**: Under the `jobs` keyword, define the steps that make up your CI pipeline. For a Node.js application, this might include:

    - **Checkout the code**: Use the `actions/checkout@v2` action to checkout your code onto the runner.

    - **Set up Node.js**: Use the `actions/setup-node@v2` action to set up the specified version of Node.js on the runner.

    - **Install dependencies**: Run `npm ci` to install your project's dependencies.

    - **Run tests**: Run `npm test` to execute your project's test suite.

    Here's what these steps might look like in the `ci.yml` file:

    ```yaml
    jobs:
      build:
        runs-on: ubuntu-latest

        steps:
        - name: Checkout code
          uses: actions/checkout@v2

        - name: Use Node.js
          uses: actions/setup-node@v2
          with:
            node-version: '14'

        - name: Install dependencies
          run: npm ci

        - name: Run tests
          run: npm test
    ```

4. **Handle test failures**: By default, if any step in a GitHub Actions job fails, the job is stopped and marked as failed. This is usually what you want for a CI pipeline - if the tests fail, you want to know about it!

5. **Create a review environment on successful CI**: This could be a new step in your CI workflow that is only run if the previous steps (your tests) succeed.

