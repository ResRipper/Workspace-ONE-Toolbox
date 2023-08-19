# Application Restrictions

[VMware Document](https://docs.vmware.com/en/VMware-Workspace-ONE-UEM/2302/macOS_Platform/GUID-AppsProcessRestrictionsformacOS.html)

## Requirements:

-   macOS version >= 10.15
-   Intelligent Hub >= 21.04

For UEM version < 2105,

> These two are included in Hub's profile for UEM version >= 2015

-   System Extension profile
-   Privacy Preferences

## Known issue

For macOS version < 10.15:

-   Profiles will be deployed, but will not effects.
-   Re-deploy is required after the system is upgraded to > 10.15

## Application Identifiers:

> Most of them can be retrived from `codesign -dvvv <path to .app or executable>`

Process that match any one of the below will be restricted

-   bundleId
    -   `CFBundleIdentifier` in `<path to .app>/Contents/Info.plist`
    -   `mdls <path to .app> | grep kMDItemCFBundleIdentifier`
    -   `CFBundleIdentifier` in `otool -P <path to executable>`
-   [cdhash](https://developer.apple.com/documentation/endpointsecurity/es_process_t/3228976-cdhash)
    -   `codesign -dvvv <path to .app or executable>`
    -   `codesign -dv --verbose=4 <path to .app or executable>`
-   name
    -   Name of the .app bundle / process
        > `App Store.app` -> `App Store`
-   path
    -   `<path to .app>/Contents/MacOS/<App executable file>`
    -   `/usr/bin/<executable>`
-   sha256
    -   `shasum -a 256 <path to .app>/Contents/MacOS/<App executable file>`
    -   `openssl dgst -sha256 <path to .app>/Contents/MacOS/<App executable file>`
