# Connectivity checks

Run these tests after the switches, VyOS routing policy and AWS environment have actually been configured. **These are expected results, not recorded test passes.**

| Source | Destination | Expected |
| --- | --- | --- |
| Admin VLAN | Allowed service ports | Connect |
| Restricted VLAN | Admin hosts | Deny |
| Restricted VLAN | Private cloud application | Deny |
| Admin VLAN | Private cloud application | Connect over tunnel |
| Internet | Private application | Deny |
| VPN gateway | Application management SSH | Connect if authorized |
| AWS application | Approved site return path | Route correctly |
| Site WireGuard peer | AWS WireGuard peer | Handshake and route test |

For each test, record source/destination, exact protocol and port, CLI or command used, expected and observed result, and timestamp. Sanitize evidence before it goes into public version control.
