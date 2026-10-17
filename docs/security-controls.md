# Security boundaries

| Boundary | Intended control |
| --- | --- |
| Restricted VLAN to admin and cloud | Deny new connections |
| Admin VLAN to required resources | Narrow, documented allow rules |
| Internet to AWS VPN node | UDP 51820 only from the configured peer source |
| Internet to SSH management | Port 22 only from an explicitly approved CIDR |
| Internet to private application | No direct public addressing |
| VPN gateway to application | Security-group-restricted access and routed return traffic |

All rules are design requirements until they are applied and tested on the actual router, switches and AWS networking. Stateful return traffic and established/related filtering depend on the platform.

Keys, live cloud resource IDs, device passwords, private disk images and original lab captures are excluded from this repository.
