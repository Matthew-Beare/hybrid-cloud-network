# Security boundaries: capstone evidence and public example

The original September 2026 capstone demonstrated EXOS 802.1Q segmentation, VyOS firewall forwarding controls, a WireGuard tunnel to AWS, and allowed/denied paths. See the [historical capstone test record](capstone-verification.md) for evidence and scope. It does **not** establish that an equivalent deployment remains operational.

The public `config/segmentation-policy.yaml` is an **illustrative human-readable design**, not applied switch or router configuration. The public `terraform/` example uses scoped ingress rules for the WireGuard/SSH gateway and keeps the application EC2 instance without a public IP. Terraform validation is not proof of correct runtime routing or isolation. The public example requires additional deployment and testing before any security claim is justified.

Do not publish cloud account IDs, live peer public endpoints, WireGuard private keys, administrator credentials, uncropped VM desktops, production network inventories, or credential-containing Terraform state files. The cropped original evidence intentionally omits or blacks out identifying peer information while retaining the observed handshake, traffic and VLAN results.
