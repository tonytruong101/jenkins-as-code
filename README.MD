## Overview

# Why? 

Waiting to install plugins is a hassle, `configuration-as-code` Jenkins plugin only covers configuration for already installed plugins so to fully impletement Jenkins as code, we will use docker to generate our own local Jenkins images that can be completely customized to your use-case

Jenkins Configuration as code. This repository will contain complete configuration setups for deploying Jenkins with various preinstalled plugins, reducing the initial installprocess time. 

Plugins can be selectively specified, also including various different Jenkins UI themes you can set within the `Dockefile`.

## Directory Setup 

- Default Jenkins plugins will be found under `.docker/jenkins_plugins/default_jenkin_plugins/`
- Custom Jenkins plugins will be found under `.docker/jenkins_plugins/custom_jenkin_plugins/`
- Custom Jenkins Themes will be found under `.docker/jenkins_plugins/custom_jenkin_plugins/themes/`

By default, only Default & Custome Jenkins Plugins will be installed during the `docker build step` Please follow the steps under `Themes` for more information on how to preinstall & configure your theme settings using `configuration-as-code` plugin.  

## Custom Plugins List 

The following are a list of Plugins that we've built into this repository. 

SCM 

- [Bitbucket](https://plugins.jenkins.io/bitbucket/)
- [GitLab](https://plugins.jenkins.io/gitlab-plugin/)
- [Generic Webhook Trigger](https://plugins.jenkins.io/generic-webhook-trigger/)

Tools

- [Configuration As Code](https://www.jenkins.io/projects/jcasc/)
- [Docker](https://plugins.jenkins.io/docker-plugin/)
- [NodeJs](https://plugins.jenkins.io/nodejs/)

Themes

- [Blue Ocean](https://plugins.jenkins.io/blueocean/)
- [Dark Theme](https://plugins.jenkins.io/dark-theme/)
- [Material Theme](https://plugins.jenkins.io/material-theme/)
- [Simple Theme](https://plugins.jenkins.io/simple-theme-plugin/)


# Quick Start

To see a working demo, simply git clone this repo then run `docker-compose up -d` which will create a new jenkins-docker-container on local.


## Dockerfile Instructions

You can create your own custom Jenkins image based off off `jenkins/jenkins` docker image that is pre-configured with plugins. Which you can then use the `configuration-as-code` Jenkins Plugin to finalize the rest of your setup. 

## Themes

Add or uncomment the following lines to your `Dockerfile` for the theme you wish to preinstall with the Jenkins docker image

# Blue Ocean

![screenshot](./src/images/jenkins_blueocean.png)
```
COPY --chown=jenkins:jenkins .docker/jenkins_plugins/custom_jenkin_plugins/themes/blue-ocean /usr/share/jenkins/ref/plugins
```
# Dark-theme

![screenshot](./src/images/jenkins_darktheme_dark.png)

```
COPY --chown=jenkins:jenkins .docker/jenkins_plugins/custom_jenkin_plugins/themes/dark-theme /usr/share/jenkins/ref/plugins
```

# Material-theme

![screenshot](./src/images/jenkins_materialtheme_red.png)

```
COPY --chown=jenkins:jenkins .docker/jenkins_plugins/custom_jenkin_plugins/themes/material-theme /usr/share/jenkins/ref/plugins
```

## Jenkins Configuration As Code (JCasc)

The following code snippets below are for your reference when building out your own `jcasc.yaml` file. During the docker build step, the docker image will be built with `CASC_CONFIGS` mounted to `/var/jenkins_home/casc_configs` which is where `configuration-as-code` will check for configuration `YAML` files.


Jenkins

A simple Jenkins `YAML` file that serves as the base of all of our `YAML` files. Applying this configuration will create a standard Jenkins Master Node with 5 concurrent builds. 

```
jenkins:
  systemMessage: "Jenkins configured automatically by Jenkins Configuration as Code plugin\n\n"
  numExecutors: 5
  scmCheckoutRetryCount: 2
  mode: NORMAL
```

Agents

A simple Jenkins Agent `YAML` configuration block that you can add within your `jcasc.yaml` files to configure your `jenkins-agents`. The following details below will include an example confiuguration block.

SSH-Agent
```
 nodes:
    - permanent:
        name: "jenkins-sshagent-1"
        remoteFS: "/home/jenkins-sshagent1"
        retentionStrategy: "always"
        launcher:
          ssh:
            credentialsId: "jenkins_ssh"
            host: "localhost:8080"
            port: 22
            sshHostKeyVerificationStrategy: "knownHostsFileKeyVerificationStrategy"
```

- `name:` The Name of your Jenkins Agent
- `remoteFS:` Location of remote directory for Jenkins Java Agent 
- `retentenionStrategy:` How often to keep this Agent Running For
- `launcher:` Our connection launcher method for the agent
- `ssh:` Our connection method
- `host:` Our Jenkins Agent server address
- `port:` Our Jenkins Agent Port
- `sshHostKeyVerificationStrategy:` SSH auth method


Inbound-Agent

```
    - permanent:
        name: "static-agent1"
        remoteFS: "/home/jenkins-agent1"
        launcher:
          inbound:
            workDirSettings:
              disabled: true
              failIfWorkDirIsMissing: false
              internalDir: "remoting"
              workDirPath: "/tmp"
```

Themes

A simple `jcasc` `YAML` block for themes 


Dark Theme

```
unclassified:
  themeManager:
    disableUserThemes: true
    theme: "dark" 
```

Material Theme

```
unclassified:
  themeManager:
    disableUserThemes: true
    theme: "material-indigo" # or 'material-red' or 'material-grey' or 'material-light-blue'
```
