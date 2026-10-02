# lmi: the KernelSU-Next manager here is preinstalled as a /product system
# app, signed with its own dedicated cert (device/xiaomi/lmi/security/
# ksu_manager/) rather than default_dev_cert -- a shared default_dev_cert
# collides with other resigned /product apps and lets the kernel's manager
# scan crown the wrong app entirely (CONFIRMED 2026-08-30 on crosshatch,
# see crosshatch-ksu-manager-product-app-bugs memory). Same keystore
# identity as the other devices; see ~/ksu-manager-build/README.md.
# Computed via: apksigner verify --print-certs + manual v2 signing-block
# cert extraction.
# Key rotated 2026-10-02: the previous key (cert 0x2ea, b22ee43b...) had its
# private key published on GitHub (device lmi repo, security/ksu_manager/), so
# any app signed with it could be crowned manager. New keystore:
# ~/ksu-manager-build/keystore/ksu-manager-2026-10.jks; the .pk8 stays local.
KSU_NEXT_MANAGER_SIZE := 0x2f3
KSU_NEXT_MANAGER_HASH := e77745f99a7cc40536d9ceb3fe050463065bbe4eb4f45f8f34691564a6b51459

# /product/app/<Module>/<Module>.apk doesn't encode the package name in its
# path (no "<pkg>-<hash>" segment for crown_manager()'s path parsing to find),
# so it needs the real package name given explicitly - see the
# get_pkg_from_apk_path fallback in kernel/manager/throne_tracker.c.
#
# Renamed 2026-09-11 from com.rifsxd.ksunext to dev.i928.mgr to match sunfish
# (kernel commit 7bfc18e) so all three devices share ONE hardened manager APK
# (applicationId + code namespace both dev.i928.mgr; the cert b22ee43b pinned
# above is unchanged, so no cert re-pin needed). Root/manager detectors keying
# on the well-known KernelSU-Next package name no longer find the baked manager.
# Requires the dev.i928.mgr manager APK (~/ksu-manager-build) in this device's
# /product prebuilt -- rebuild kernel to bake this pin, and ROM to bake the APK.
KSU_MANAGER_PACKAGE := dev.i928.mgr
