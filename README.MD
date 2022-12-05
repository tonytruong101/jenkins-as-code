## Overview

# Why? 

Waiting to install plugins is a hassle, `configuration-as-code` Jenkins plugin only covers configuration for already installed plugins so to fully impletement Jenkins as code, we will use docker to generate our own local Jenkins images that can be completely customized to your use-case

Jenkins Configuration as code. This repository will contain complete configuration setups for deploying Jenkins with various preinstalled plugins, reducing the initial installprocess time. 

Plugins can be selectively specified, also including various different Jenkins UI themes you can set within the `Dockefile`.

## Directory Setup 

Default Jenkins plugins will be found under `.docker/jenkins_plugins/default_jenkin_plugins/`
Custom Jenkins plugins will be found under `.docker/jenkins_plugins/custom_jenkin_plugins/`
Custom Jenkins Themes will be found under `.docker/jenkins_plugins/custom_jenkin_plugins/themes/`

By default, only Default & Custome Jenkins Plugins will be installed during the `docker build step` Please follow the steps under `Themes` for more information on how to preinstall & configure your theme settings using `configuration-as-code` plugin.  

# Quick Start

To see a working demo, simply git clone this repo then run `docker-compose up -d` which will create a new jenkins-docker-container on local.


## Dockerfile Instructions

You can create your own custom Jenkins image based off off `jenkins/jenkins` docker image that is pre-configured with plugins. Which you can then use the `configuration-as-code` Jenkins Plugin to finalize the rest of your setup. 


# Themes

Add or uncomment the following lines to your `Dockerfile` for the theme you wish to preinstall with the Jenkins docker image

Blue Ocean

![screenshot](./src/images/jenkins_blueocean.png)
```
COPY --chown=jenkins:jenkins .docker/jenkins_plugins/custom_jenkin_plugins/themes/blue-ocean /usr/share/jenkins/ref/plugins
```
Dark-theme

![screenshot](./src/images/jenkins_darktheme.png)

```
COPY --chown=jenkins:jenkins .docker/jenkins_plugins/custom_jenkin_plugins/themes/dark-theme /usr/share/jenkins/ref/plugins
```
