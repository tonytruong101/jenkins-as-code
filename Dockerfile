FROM jenkins/jenkins

## Default Plugins that are recommended by Jenkins during intial installation. 

COPY --chown=jenkins:jenkins .docker/jenkins_plugins/default_jenkin_plugins /usr/share/jenkins/ref/plugins

## Custom Plugins. You can set this up to copy the entire directory or target your own plugins. 

## Copy entire custom jenkins plugin directory.

COPY --chown=jenkins:jenkins .docker/jenkins_plugins/custom_jenkin_plugins/*/ /usr/share/jenkins/ref/plugins

## copy one specific plugin 

# COPY --chown=jenkins:jenkins .docker/jenkins_plugins/custom_jenkin_plugins/directory/plugin.jpi /usr/share/jenkins/ref/plugins

## Uncomment the them you want, it isn't recommended to use multiple themes.

## Build Jenkins Image with Blue Ocean Theme
#COPY --chown=jenkins:jenkins .docker/jenkins_plugins/custom_jenkin_plugins/themes/blue-ocean /usr/share/jenkins/ref/plugins

## Build Jenkins Image with Dark-theme
#COPY --chown=jenkins:jenkins .docker/jenkins_plugins/custom_jenkin_plugins/themes/dark-theme /usr/share/jenkins/ref/plugins
