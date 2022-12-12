# F5 XC ADN Lab

<wip>

Lab setup to demonstrate "brown field" Application Delivery across public cloud and on premise sites using
F5 XC.

Folders:

- [infra](infra) create VPC and subnets and k8s clusters to build brown field topology
- [virtual](virtual) create virtual sites vk8s clusters for dev, pre and prod environments and deploys simple consul services for each environment (web interface exposed via LB on IGW connecting the on premise lab). Doesn't depend on existing infrastructure, as it provisions objects in F5 XC that come to life once sites are labelled according to virtual sites.
- [workloads](workloads) create workload instances in each brown field subnet and k8s cluster and register them via consul (depends only on infra)
- [services](services) create services (LB/origin pools) for the various workloads (depends only on virtual)
- [sites](sites) deploy F5 XC sites into existing infrastructure, automatically providing the services provisioned for the virtual sites (no dependencies)

Each logical environment (dev, pre and prod) gets its own virtual site and vk8s cluster, identified via label and assigned to F5 XC sites. These sites can be built and destroyed anytime, without impacting other sites using the services. Application services are provisioned in F5 XC based on virtual sites, using custom VIPs and registering via provided Consul services per environment. It is possible to have a site provide application delivery services for more than one environment, either by using shared custom VIP (or internal/external interface) or separate custom VIPs (e.g. custom VIP per environment).


