# audiodecoder.openmpt addon for Kodi

This is a [Kodi](https://kodi.tv) audio decoder addon for tracker module files.

This is a **custom fork** of the official OpenMPT Audio Decoder for Kodi.

**STATUS: Enthusiast Mod / Custom Build**

This addon is designed for users who want to experience tracker music (MOD, IT, XM, S3M, etc.) in full, discretely-mixed 5.1 surround sound within Kodi.

## 🚨 IMPORTANT NOTICES

1. **Kodi Compatibility:** This addon has been specifically built and tested for **Kodi v21 (Omega)**. Compatibility with other versions (e.g., v20 Nexus or v22 Piers) is not guaranteed.
2. **Dependency:** This addon requires a **custom-compiled version of the underlying `libopenmpt` library** which includes the necessary 5.1 mixing engine. This library fork is maintained in a separate repository: [https://github.com/mainLink0435/openmpt](https://github.com/mainLink0435/openmpt)
3. **Official Status:** This addon is **not affiliated** with the official Kodi or `libopenmpt` projects. For the foreseeable future, this feature will not be part of the official Kodi addon, as it conflicts with the upstream `libopenmpt` philosophy of strict archival fidelity.

## ✨ The 5.1 Surround Mix Advantage

This custom build provides a superior spatial experience for module files:

* **Pre-Mix Panning:** Unlike generic AVR upmixers or matrix filters, this mod works directly with the module's raw spatial data, before the audio is mixed to stereo. This is the only way to genuinely distribute the sound across all six channels (FL, FR, Center, SL, SR, LFE).
* **Enhanced Immersion:** For the enthusiast community, this technique creates an immediate and subjectively enhanced spatial experience that opens up the sound beautifully for modern multi-channel systems.

[![License: GPL-2.0-or-later](https://img.shields.io/badge/License-GPL%20v2+-blue.svg)](LICENSE.md)
[![Build and run tests](https://github.com/xbmc/audiodecoder.openmpt/actions/workflows/build.yml/badge.svg?branch=Nexus)](https://github.com/xbmc/audiodecoder.openmpt/actions/workflows/build.yml)
[![Build Status](https://dev.azure.com/teamkodi/binary-addons/_apis/build/status/xbmc.audiodecoder.openmpt?branchName=Nexus)](https://dev.azure.com/teamkodi/binary-addons/_build/latest?definitionId=10&branchName=Nexus)
[![Build Status](https://jenkins.kodi.tv/view/Addons/job/xbmc/job/audiodecoder.openmpt/job/Nexus/badge/icon)](https://jenkins.kodi.tv/blue/organizations/jenkins/xbmc%2Faudiodecoder.openmpt/branches/)

<!--- [![Build Status](https://ci.appveyor.com/api/projects/status/github/xbmc/audiodecoder.openmpt?branch=Nexus&svg=true)](https://ci.appveyor.com/project/xbmc/audiodecoder-openmpt?branch=Nexus) -->

## Build Instructions

These instructions are for building the addon on a Linux-based system.

### Prerequisites

1. **A pre-compiled `libopenmpt.a` library.** This addon requires a specific custom version of the libopenmpt library that has 5.1 surround mixing capabilities. You can get the source code to compile it yourself from this repository:

   - **[https://github.com/mainLink0435/openmpt](https://github.com/mainLink0435/openmpt)**
2. **Build Tools:** You will also need the following tools installed:

   - `git`
   - `build-essential` (on Debian/Ubuntu for `g++`, `make`)
   - `cmake`
   - `patchelf`
   - `zip`

### 1. Directory & Library Setup

The build system requires a specific directory structure to locate the `libopenmpt.a` library.

First, clone this `audiodecoder.openmpt` repository. Then, create a parallel directory named `openmpt` and place the library within it as shown below.

```
/your/build/folder/
├───openmpt/
│   └───bin/
│       └───libopenmpt.a  <-- Place the pre-compiled library here
│
└───audiodecoder.openmpt/  <-- The repository you are currently in
```

### 2. Build & Package the Addon

Once the prerequisites are met and the directory structure is correct, you can build the addon.

```bash
# From the 'audiodecoder.openmpt' directory

# Step 2.1: Configure with CMake, compile, and copy addon resources
bash -c "cmake -S . -B build && cmake --build build && bash copy_resources.sh build"

# Step 2.2: Navigate into the build directory to create the zip
cd build

# Step 2.3: Create the final installable package
zip -r audiodecoder.openmpt.zip audiodecoder.openmpt
```

The resulting `audiodecoder.openmpt.zip` can be installed in Kodi via the "Install from zip file" option.
