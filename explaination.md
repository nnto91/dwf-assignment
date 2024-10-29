## This solution provisions a high-availability Elasticsearch cluster on Google Kubernetes Engine (GKE) using Terraform and the Helm provider:


## 1. GKE Cluster Type:
Zonal Cluster: Since regional clusters are more expensive due to node replication across zones, using a zonal cluster will help reduce costs significantly.
Management Fees: GKE standard clusters have a management fee of $0.10 per hour only if the cluster has autopilot enabled or node-based usage above the free tier ~ $74,4 monthly. For now, let’s proceed with a single zonal cluster to avoid extra costs.

## 2. Node Pools and Machine Type:
Node Pools: Use at least two node pools, but for production grade three node pools is better:
Machine Type: For budget-conscious performance, consider the e2-medium (2 vCPU, 4 GB RAM) for smaller workloads or e2-standard-2 (2 vCPU, 8 GB RAM) if your workload requires more memory. Start with the smaller configuration and adjust if necessary, to ensure costs stay within budget.

## 3. Solution Design Summary:
Tech Stack: Use Terraform provisioning the Elasticsearch on a GKE zonal cluster with Kubernetes-managed deployments for high availability.
Deployment Approach: Use Helm charts to deploy and configure Elasticsearch components in separate pods across the node pools.
Authentication Options: There are two certificate management options for securing Elasticsearch:
 - Automated Certificate Creation: Enable built-in Helm options to automatically generate SSL certificates, simplifying setup.
 - Manual Certificate Creation: Manually create and manage certificates, domain name of elastic cluster for full control over security configurations, ideal for production needs. (choose this options)
Security: Create a elastic credentails for authorize with user and password

## 4. Estimated Time to Complete:
About 8-10 hours, including Terraform GKE setup, configuring and testing Elasticsearch, implementing authentication, and cost calculating.

## 5. Cost calculation:
- Assume we have GKE free tier with $74,4 monthly only for Zonal cluster or Autopilot, so the management fees of GKE cluster will be free
- Select the regional **us-central1** with Low CO2 for the lower costs
- Purchase 3 years of CUD with E2 commitment types for 6 vCPUs and 12Gb Ram to get more discounts
- Node Pool: 
    Use a single node pool with 2 e2-medium nodes (2 vCPU, 4 GB RAM each) to support the Elasticsearch nodes. This is sufficient for a low-volume cluster, where 3 nodes can provide minimal redundancy.
    Cost per e2-medium: $0.03 per hour (~$25,46 per month per node).
    Total Compute for 3 e2-medium nodes: $76,38/month. 
    --> After applied CUDs = $34,62/month

- Storage Costs:
    Persistent Disk: Use standard persistent disks for storage, which are cheaper than SSDs. Assuming a modest data storage requirement of 50 GB per node, the costs are as follows:
    Cost per 50 GB for Zonal standard PD: ~$1 per month.
    Total for 3 nodes: $3/month.
- Networking Costs:
    Internal Communication: For zonal clusters, internal communication is free.
    Egress Costs: Let’s assume minimal external data transfer (~50 GB/month), resulting in low networking costs, around $5/month.

- Monthly Cost Summary
    Compute (e2-medium nodes):  $34,62
    Storage (3 x 50 GB): $3
    Networking (low egress): $5
    GKE Cluster Management: $0 (if within free tier limits)
    Total Estimated Monthly Cost: $42,62/month

**Total 6-Month Cost** 
## 6-Month Total: $42,62 * 6 ≈ $255,72