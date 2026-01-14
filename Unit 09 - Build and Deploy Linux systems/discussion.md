Unit 9 Discussion Post 1: Read sections “Container Usage” and “Diskless Booting” on pages 8 and 9 of this doc: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-223.ipd.pdf
What are the main security concerns given about using containers in HPC?
```

If you really want to hide something, put it in a non-clear container and then put it on the top shelf in the pantry way in the back, or in the attic! This way it'll be out of sight, out of mind, and you won't find it until you are not actively engaged in finding it, but have considered it lost for many years. In the case of something organic, it may decide to find you when the time is right.

Security risks have very similar analogies. Containers can mask software vulnerabilities and make them harder to find and detect by normal means. Containers offer namespaces and isolated network stacks that can be used, if improperly configured, to hide or obfuscate malicious activity.

Keeping containers confined within themselves or within their namespace is critical because gaining access to other containers or kernel-level access can be catastrophic  and have catastrophic consequences with the wrong permission set. 

Containers need to maintain isolation and confined privileges or controlled privileges that are carefully configured to operate in isolation. If configurations are set up properly, then inter-container communication or inter-namespace communication can be carefully configured and secure within the overall system.
```






What is the PXE or IPXE protocol defined for diskless booting?

```
PXE (Preboot eXecution Environment): this is the protocol that enables nodes on a network, or with a network configured device, to boot from a small image. This is usually configurable at the BIOS level in a setting. Once enabled, it allows a node to reach out to a network server using standard network services and obtain bootstrap information, which usually includes an image for startup. 

IPXE is an open source implementation of the same with more recent additions of protocols such as HTTP and iSCSI. These additional protocols allow for more flexibility in how boot images are served out as bootstrap.

In terms of High Performance Compute, these are used in different configurations to customize configurations in containers or clusters, and also allow for the centralized management of containers, images, and clusters. High-speed networking of the current era allows for reliable idempotent system creation within HPC frameworks and removes the complexity and cost of local storage associated with the containerized or imaged system.



```
