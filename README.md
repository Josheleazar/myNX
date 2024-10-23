# Automated Kubernetes Cluster Deployment with Monitoring and Autoscaling

## Project Overview
This project demonstrates the setup of a fully automated Kubernetes cluster deployed on Google Cloud Platform (GCP) using Terraform. The cluster is monitored using Prometheus and Grafana, and it includes autoscaling functionality at both the pod and node levels, leveraging Horizontal Pod Autoscaler (HPA) and Cluster Autoscaler.

### Key Features
- Infrastructure as Code: Using Terraform to provision GCP resources such as a VPC, GKE Cluster, Load Balancers, and IAM roles.
- Containerized Application: Deployment of a lightweight Nginx application on the Kubernetes cluster.
- Monitoring: Integrated Prometheus for metrics collection and Grafana for visualization.
- Autoscaling:
    - Horizontal Pod Autoscaler (HPA) to adjust the number of Nginx replicas based on CPU utilization.
    - Cluster Autoscaler to automatically add or remove nodes from the GKE cluster based on resource demand.

## Environment Setup
### Prerequisites
1. Google Cloud Account: Ensure you have a GCP project set up with billing enabled.
2. Terraform: Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
3. GCP SDK: Install the [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) for authentication.
4. Helm: Install [Helm](https://helm.sh/docs/intro/install/) for deploying Prometheus and Grafana.
5. Kubectl: Install [kubectl](https://kubernetes.io/docs/tasks/tools/) to manage the Kubernetes cluster.


## Steps to Provision the Infrastructure
**Step 1: Clone the Repository**

`git clone git@github.com:Josheleazar/myNX.git`

**Step 2: Authenticate to GCP**
Ensure you're using the appropriate GCP credentials for your own project.

`gcloud auth login`

`gcloud auth application-default login`

**Step 3: Initialize and Apply Terraform**

`terraform init`

`terraform plan`

`terraform apply`

Those three commands will create a VPC, GKE cluster, IAM roles, and networking components required for the Kubernetes cluster.

**Step 4: Configure Kubernetes Access**

Once the GKE cluster is provisioned, configure kubectl to access the cluster.

`gcloud container clusters get-credentials k8s-cluster --zone us-central1-a --project your-gcp-project-id`

`gcloud container clusters get-credentials k8s-cluster --region us-central1 --project your-gcp-project-id`

Use the first commad incase you've provisioned a zonal cluster, and the second for a regional cluster.

Additionally an [Authorization Plugin](https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke) may be required at initial setup.

**Step 5: Deploy Nginx on GKE**

Since we're using terraform, cluster objects are provisioned using k8s resource scripts in HCL.
Therefore the `terraform apply` command will have to be run again to create the cluster objects using the new connection we created in the previous step.

**Step 6: Install Prometheus and Grafana using Helm**

Run the following commands.

`helm repo add prometheus-community https://prometheus-community.github.io/helm-charts`

`helm repo add grafana https://grafana.github.io/helm-charts`

`helm install prometheus prometheus-community/prometheus`

`helm install grafana grafana/grafana`

**Step 7: Configure Horizontal Pod Autoscaler (HPA)**

Run the following command from within the Google Cloud SDK shell.

`Step 7: Configure Horizontal Pod Autoscaler (HPA)`


**Step 8: Access Prometheus and Grafana**

Helm will initially install prometheus and grafana as ClusterIP services.
Meaning they will only be accessible from inside the cluster.
To expose them to web traffic, run the these.

`kubectl expose service grafana --type=LoadBalancer --target-port=3000 --name=grafana-ext`

`kubectl expose service prometheus-server --type=LoadBalancer --target-port=9090 --name=prometheus-server-ext`

`Kubectl get svc`
outputs a table containing an external-ip column that shows the addresses through which all the services can be externally accessed. 

Finally,
`kubectl get secret --namespace default grafana -o yaml` 
run the encoded string admin-password exposed by the output from this command through any base64 decoder software or plugin.
Use that as your grafana password with the username "admin".

### Terraform Files

- **providers.tf**: Configures GCP and Kubernetes providers.
- **IAM.tf**: Assigns the nessecary IAM roles to the project service account.
- **VPC.tf**: Creates a GCP VPC network and subnet with a custom IP range of up to 255 hosts.
- **GKE.tf**: Provisions the GKE cluster with a separately managed node pool.
- **loadbalancer.tf**: Creates a Kubernetes service for the mynx application externally accessible through port 80.
- **mynx.tf**: The Kubernetes deployment for the mynx application.
- **Outputs.tf**: This outputs key information about the GKE cluster, including the cluster's endpoint, a generated kubeconfig for accessing the cluster, and details about the associated node pool, such as its name, machine type, and current node count.
- **locustfile.py**: A Locust load test user class that simulates accessing the root URL of the Nginx server.

## Key Learnings and Challenges Faced

### Key Learnings

1. Infrastructure as Code: Gained practical experience with Terraform to automate cloud infrastructure provisioning.
2. Kubernetes Cluster Setup: Learned how to deploy a fully managed Kubernetes cluster on GCP using GKE.
3. Monitoring and Autoscaling: Integrated Prometheus and Grafana to monitor cluster resources, and implemented autoscaling mechanisms (HPA and Cluster Autoscaler) to ensure optimal resource utilization.

### Challenges Faced

- **Cluster Provisioning Realization:** I initially thought enabling GKE would be enough, but I had to provision a VPC, subnets, IAM roles, and other services to get the cluster running.
- **Terraform Integration:** Connecting Terraform to GKE was tricky. I had to add a Kubernetes provider block and install the gcloud CLI authorization plugin for proper connectivity.
- **Grafana Setup:** Setting up Grafana dashboards was a nightmare due to my unfamiliarity with PromQL. I eventually found a prebuilt K8s dashboard that suited my needs.

## Future Improvements

- **Terraform modules** 

    These promote reusability, abstraction, and consistency, allowing for cleaner, more maintainable code, which makes it easier to manage complex infrastructure, and ensure configurations are uniform across environments.

- **CI/CD Pipeline**

    Automate the infrastructure deployment and application updates via a CI/CD pipeline (e.g., GitHub Actions or Jenkins).

## Contact Information
Feel free to reach out if you have any questions or need further assistance:

Name: Josh Eleazar

Email: joelson30.j@gmail.com

LinkedIn: https://www.linkedin.com/in/josheleazar/