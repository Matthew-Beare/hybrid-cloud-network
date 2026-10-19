# Network verification: recorded capstone versus future example

The historical capstone **was implemented and tested in September 2026**. Eight test cases and their reported observations are summarized in [capstone-verification.md](capstone-verification.md), with representative cropped original screenshots in `docs/evidence/`.

The matrix below applies **only if someone independently deploys the generalized `terraform/` example and completes its currently missing WireGuard/VyOS/router bootstrap**. These are **expected future outcomes, not new recorded test passes**.

| Source | Destination | Expected result for future generalized deployment |
| --- | --- | --- |
| Admin VLAN | Approved local service ports | Connect |
| Restricted VLAN | Administrative hosts | Deny |
| Restricted VLAN | Private AWS application | Deny |
| Admin VLAN | Private AWS application | Connect through tunnel |
| Internet | Private application EC2 | Deny |
| Authorized VPN gateway | Application management SSH | Connect |
| AWS application | Approved site return path | Correct reverse route |
| Site WireGuard peer | AWS peer | Valid handshake and working bidirectional routing |

For a future deployment record source/destination, port, exact command, expected and observed result, UTC timestamp, and a sanitized screenshot or capture. A VPN handshake alone never proves end-to-end reachability.
