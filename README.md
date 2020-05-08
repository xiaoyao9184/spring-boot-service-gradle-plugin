# spring-boot-service-gradle-plugin

Generate service file in build time.

**NOTE** this project is not real plugin of gradle

## Principle

Use [winsw](https://github.com/winsw/winsw) for windows, [systemd](https://github.com/systemd/systemd) for linux

## Used

Just apply it in spring boot project 

```groovy

project(':some-spring-boot') {
    apply plugin: 'java'

    apply from: 'https://raw.githubusercontent.com/xiaoyao9184/spring-boot-service-gradle-plugin/master/gradle/services.gradle'
}
```

## Custom location for repository

Just use variable.

gradle.properties
```properties
serviceLanguage=zh_CN
serviceTemplateGit=http://www.like-gitlab.com/yourname/spring-boot-service-gradle-plugin/raw/master
```

build.gradle
```groovy

project(':some-spring-boot') {
    apply plugin: 'java'

    apply from: "${serviceTemplateGit}/gradle/services.gradle"
}
```

## Custom service template

By default, 
the templates in this repository will be downloaded to the '.service' directory of project 
for generating service config files.

If the template file is already in the '.service' folder, the local file will be used first.

default template for window
[winsw](./template/winsw/winsw.xml.template)
[winsw exe](./template/winsw/winsw.exe.config.template)

default template for window
[systemd](./template/systemd/systemd.service.template)


### Use variables in template

You can use the following variables in the template.

- version
- service
- project
- rootProject

__project__ and __rootProject__ variables are gradle model

__version__ form `"${version}"`

__service__ include 
  
  *systemd only*
  - rootName: form `project.overrideRootName` or `rootProject.name`
  - systemdBuildDir: is `${service.buildDir}/systemd-service/${service.profile}`
  
  *winsw only*
  - netVersion: is `net4`
  - winswVersion: is `2.3.0`
  - winswBuildDir: `${service.buildDir}/winsw-service/${service.profile}`
  
  *all*
  - profile: form `project.profile`
  - language: form `project.serviceLanguage` default is `en_US`
  - downloadUrl: form `project.serviceTemplateGit` default is `https://raw.githubusercontent.com/xiaoyao9184/spring-boot-service-gradle-plugin/master`
  - templateDir: is `${rootProject.rootDir}/.service`
  - buildDir: is `${project.buildDir}/services`
