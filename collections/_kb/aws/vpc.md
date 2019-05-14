---
tech: aws
title: VPC
---

A VPC has to be considered as a logical isolation of resources. A VPC can contains
one or more subnets which represents a sub division of the isolations. A VPC is
attached to a region and attached subnets are attached to one and only one 
availability zone within the region.

## VPC

Some useful knowledge:

- [Wikipedia: Classful network](https://en.wikipedia.org/wiki/Classful_network)
- [Wikipedia: Classless Inter-Domain Routing (CIDR)](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)

A VPC must be created within a given region with a specific region with 
a CIDR block. This CIDR block is the primary one and cannot be removed.

VPC can also configure:
- DHCP options. All options are defined in `DHCP Options Sets` page
- DNS resolution and hostname. Enable DNS hostname to have an URL
  for th EC2 instances
- IPv6 is optional but CIDR cannot be chosen and is imposed by AWS

## Subnet, route tables & internet gateway

Each subnet:
- has a CIDR block as a subnet of the VPC CIDR
- has one availability zone
- has one route table
- can enable automatic IPv4 address assignment
- has one network ACL, which is like a firewall before the subnet

> The first four IP addresses and the last IP address in each subnet CIDR block are not available for you to use, and cannot be assigned to an instance. For example, in a subnet with CIDR block 10.0.0.0/24, the following five IP addresses are reserved:
> - 10.0.0.0: Network address.
> - 10.0.0.1: Reserved by AWS for the VPC router.
> - 10.0.0.2: Reserved by AWS. The IP address of the DNS server is always the base of the VPC network range plus two; however, we also reserve the base of each subnet range plus two. For VPCs with multiple CIDR blocks, the IP address of the DNS server is located in the primary CIDR. For more information, see Amazon DNS Server.
> - 10.0.0.3: Reserved by AWS for future use.
> - 10.0.0.255: Network broadcast address. We do not support broadcast in a VPC, therefore we reserve this address.

from: <https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html>

A subnet can be either public or private. This is defined by the
associated route. 

Sources:
- <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html>
- <https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html>
- <https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html>

### Route tables

When creating a VPC, a default route table is created. Each subnet not explicitely
assigned a route table is automatically assigned the default route table.

Gateway is defined by adding the destination `0.0.0.0/0`.

### Public subnet

A public subnet has its resources accessible from the internet and
those resources can access to Internet as well. To create a public
subnet:

- Create or edit the route table assigned to the subnet
- Create an Internet Gateway if required.
- Assigned the internet gateway to the route table

Internet gateway allows internet communication for a route table.

### Private subnet

For security reasons, some resources might be hidden from the evil Internet.
A private subnet is the response for that. In such subnet, the assigned
route table does not have an Internet gateway. If we leave it as it is,
resources inside the private subnet cannot access Internet and cannot
be accessed from the Internet.

- Access to Internet for private resources:
    - Use a NAT gateway instead of a Internet gateway
    - Such access does not allow access **from** Internet
- Access from Internet
    - Use a virtual private gateway instead of a internet gateway
    - Configure a site-to-site VPN to the virtual private gateway
