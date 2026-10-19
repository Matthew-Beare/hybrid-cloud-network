# Hybrid Cloud Network architecture

## Completed original capstone (September 2026)

The original implementation combined two ExtremeXOS switches in GNS3, VyOS inter-VLAN routing and firewall controls, and a WireGuard site-to-AWS tunnel using actual EC2 instances. The clinical, admin and services segments were VLAN 10, VLAN 20 and VLAN 30 respectively. The evidence-backed topology is summarized in the root README and [capstone verification](capstone-verification.md).

- EXOS switching: captured VLAN/802.1Q configuration and switch port membership
- VyOS: DHCP, routing, forwarding policy, and WireGuard termination
- AWS: VPN/application EC2 nodes in separate subnets and an observed return route
- Positive and negative controls: admin traffic permitted, clinical-origin cloud traffic denied

The original capstone was verified at the time; it is not claimed to be running today. The published cropped screenshots and the SW1/SW2 configuration excerpts document this historical implementation.

## Standalone Terraform example in this repository

The tracked `terraform/` example is **not an export of the implemented capstone**. It provisions sample EC2 instances/security groups using an existing VPC, public/private subnet IDs and approved narrow source CIDRs. It deliberately excludes the original tunnel keys, endpoint, cloud account metadata, appliance images and active infrastructure state.

To make the generalized Terraform example a complete working site-to-cloud connection, an operator would still need to create routes, configure VyOS and WireGuard peers and forwarding, bootstrap OS/application services, and test positive and negative paths. That work is **not covered by its static Terraform CI job**. See [verification matrix](verification-matrix.md).
