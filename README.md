# install_ruby
##### Cookbook Version
- 0.1.0

##### Dependencies
- apt
- yum

##### Supports
RHEL/Debian platforms
## Description
This cookbook will install the latests stable version of Ruby (2.4.0) with rbenv.  By default, this cookbook will automatically decide which installation method is best, depending on your node's platform.  More platforms will be added later.

## Attributes
All attributes for this cookbook are currently set to default.  If you wish to make any changes, such as the version of Ruby you would like to install, go to ```/attributes/default.rb``` to edit them.

## Recipes
###### default.rb
The default recipe acts a run list, and will install Ruby with rbenv if the platform is supported.
###### user.rb
This recipe will create the default user and group on your node.
###### debian.rb
This recipe acts a pre-requisite for the installation of Ruby with rbenv on Debian platforms.  It will install the necessary default packages on your node to allow ```rbenv.rb``` to install ruby.
###### rhel.rb
This recipe acts a pre-requisite for the installation of Ruby with rbenv on RHEL platforms.  It will install the necessary default packages on your node to allow ```rbenv.rb``` to install ruby.
###### rbenv.rb
This is where the magic happens.  This recipe will install Ruby and rbenv via git resources, set the global standard, and bundle.

## Testing
Unit tests are performed through ChefSpec.  Every recipe in this cookbook has appropriate tests to verify proper installation of Ruby with rbenv.  If you need to make any changes to the tests in this cookbook, go to the ```/spec/unit/recipes/``` directory, and make your necessary edits.  All unit tests currently pass.

###### Author:
Patrick Dayton  daytonpa@gmail.com
