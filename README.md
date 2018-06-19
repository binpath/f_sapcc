# [f_sapcc](https://github.com/binpath/f_sapfcc)

Installs SAP jvm and SAP Cloud Connector and includes recipes for installing and inspec validation. 

## Requirements

### Platforms

- RHEL/CentOS

### Chef

- Chef 12.14+

## Usage

Include the default recipe to install node on your system based on the default installation method:

```chef
include_recipe "f_sapcc::default"
```

```chef
chef-client -z --runlist 'recipe[f_sapcc::default]' 
```


## Authors

**Author:** Cesar Felce (cfelce@gmail.com)

