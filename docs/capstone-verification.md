# Completed capstone: implementation and verification

**Environment:** September 2026, GNS3 with ExtremeXOS SW1/SW2, VyOS R1, client/service nodes, and live AWS EC2 instances. This is historic lab execution evidence, **not** a representation of currently deployed infrastructure.

The original functionality report records eight test cases. The following is a condensed source-grounded index; the public screenshots are curated selections rather than the entire assignment submission.

| Test | Tested behavior | Reported observation |
| --- | --- | --- |
| 01 - VLANs/802.1Q | EXOS VLAN IDs, tagged trunks, VyOS VLAN interfaces, authorized/denied inter-VLAN pings | PASS: matching port membership and VLAN tags; Admin could ping Clinical; reverse path blocked |
| 02 - Local addressing | Admin/Clinical DHCP and Services static IPv4/default route | PASS: expected leases and service addressing; server reached its gateway |
| 03 - Local firewall | Admin permitted to local service; Clinical denied | PASS: 5 authorized replies; denied attempts timed out; VyOS forward default-drop configuration recorded |
| 04 - Cloud segmentation | Separate EC2 VPN/application subnets; VPC local routing | PASS: observed different AWS subnet assignments and route table |
| 05 - Cloud addressing | Cloud instance addressing and relevant network attributes | PASS according to the original functionality report |
| 06 - Cloud security | Permitted application traffic and restricted management access | PASS according to the original functionality report |
| 07 - Custom WireGuard VPN | Admin → AWS application reachability through VPN, handshake/traffic, AWS return route | PASS: 5 application replies, recent handshake and packet counters, active return route |
| 08 - Hybrid security | Admin → AWS allowed, Clinical → AWS blocked | PASS: 5 Admin replies, restricted Clinical attempts timed out, VyOS firewall default-drop and explicit allow verified |

## Evidence map

- `evidence/exos-sw1-vlans.png`, `evidence/exos-sw2-vlans.png`: actual `show configuration vlan` output in the GNS3 lab.
- `configs/sw1-exos-vlans.txt`, `configs/sw2-exos-vlans.txt`: exact VLAN/tag/port-membership excerpts from the original saved lab configurations; unrelated appliance settings omitted.
- `evidence/admin-clinical-allowed.png`, `evidence/clinical-admin-blocked.png`: positive and negative inter-VLAN tests.
- `evidence/vyos-firewall.png`: VyOS firewall policy output used to explain expected allowed and denied traffic.
- `evidence/wireguard-handshake.png`: observed tunnel interface and recent handshake with traffic counters; peer public keys and external endpoint have been visibly redacted.
- `evidence/admin-aws-allowed.png`, `evidence/clinical-aws-blocked.png`: end-to-end successful and denied access to the AWS application.

Screenshots are cropped from the original lab output. They are not synthetic reproductions. Original desktop chrome, identifiers, and private tunnel endpoint are excluded; relevant commands/results remain. Lab RFC1918 addressing appears where necessary to demonstrate routing. Do not infer those addresses belong to a production home or employer network.

## Reproduction boundary

Reproducing the original integration would require compatible GNS3 appliances/images, correctly configured EXOS/VyOS, a disposable AWS account, fresh EC2 subnets/security groups/routes, and newly generated WireGuard keys. Neither the original key material nor the live public VPN endpoint is published. The simplified `terraform/` folder alone will **not** re-create the tested capstone.
