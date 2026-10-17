# Routing and network design

## Site VLANs

- VLAN 10: restricted clients
- VLAN 20: administrative hosts
- VLAN 30: shared services

Switch access ports and tagged uplinks must be explicitly mapped. VyOS handles inter-VLAN routing and filtering. The example keeps switching and policy enforcement separate; adding a dedicated management VLAN would be the next hardening step.

## Cloud side

The proposed WireGuard peer runs on a gateway EC2 instance. A separate application instance sits in a private subnet. Both site and AWS route tables need the remote networks; return paths are just as important as outbound paths. The gateway also needs forwarding rules and `source_dest_check = false`.

Security groups enforce AWS-side source filtering. The gateway's SSH management port should only accept known management IPs. Never open the private application to the internet to work around missing routes.

## Implementation still required

- WireGuard setup, key distribution and rotation
- Cloud-init or Ansible bootstrap of the VPN and application nodes
- VPC route-table entries and on-prem route policy
- Firewall rules, switch trunk configuration and configuration backups
- Tested tunnel recovery, logging, negative-path checks and infrastructure teardown

The checked-in Terraform covers some EC2 and security-group resources, not the end-to-end connection.
