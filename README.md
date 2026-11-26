<div align="center">

## Containers

_An opinionated collection of container images based off of [the work by the home-operations team](https://github.com/home-operations/containers)_

</div>

## Image signatures and SBOMs

The release workflow signs the multi-architecture image index, which identifies
the platform-specific images under an image tag. It also generates, scans, and
attests a separate SBOM for each platform image digest. Verify the index
signature when deploying by index digest, and use the matching platform
digest when verifying an SBOM attestation.

These changes apply to future releases; existing images are not retroactively
signed or attested.
