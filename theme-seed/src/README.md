# GoodHuddle Theme Seed


## First run (or the long way of doing it)

To (re)build the custom bootstrap:

1. Copy all LESS files (currently just `variables.less`) to 
  `bower_components/bootstrap/less`.

2. cd ./bower_components/bootstrap

3. Make sure `grunt-cli` is installed (`npm install -g grunt-cli`).

4. Run `npm install` in this directory to install the things that bootstrap 
needs.

4. Run `grunt dist --force`
The '--force' option is needed to ignore the errors about missing doc 
files. They are not included here.


## The quick way

Shortcut: If you are sure he above is working, you can just run the 
`rebuild_bootstrap.sh` script from the directory that is resides in.
