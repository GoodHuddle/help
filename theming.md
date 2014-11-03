# How to build a custom GoodHuddle Theme

## About themes

Themes are used to give a GoodHuddle website a distinct look and feel. 

Custom themes can be created and uploaded to your own Huddle to completely change the way your Huddle website looks. From colours, to fonts, to the entire layout and positioning of headers, footers and menus. Everything in a GoodHuddle website is completely customisable - you decide how your website looks. 
 
GoodHuddle Themes are built using standard HTML and CSS. If you know how to use these then you know how to build a GoodHuddle theme. To make things easier, GoodHuddle also uses [Bootstrap](http://getbootstrap.com) and a splash
of [Handlebars](http://handlebarsjs.com/expressions.html) but you don't need to know much about these to get started. 

### The theme package file structure

Themes are packaged into ZIP archives and follow a set directory structure. This ZIP file can contain any number of HTML templates, CSS files, images and even custom JavaScript. The most simple theme however has the following three files: 

```sh
/site.xml
/thumbnail.png
/layouts/default-layout.hbs
```

The `site.xml` file is a simple XML file that describes your theme. The `thumbnail.png` is a screenshot of your theme that people see when choosing a theme to install. These two files don't affect how your site looks but are useful in keeping track of information about your theme for others when using it. 

The `default-layout.hbs` file is the base layout for your theme. This a HTML template file that defines the outer layout of your theme (i.e. the header, menu, footer, etc). The `.hbs` extension is to indicate this layout uses Handlebars - we'll explain more about this later. 

## Using the `seed` theme

todo

## Creating the `default-layout.hbs` file

...

## Additional layouts

The `default-layout.hbs` file is the only layout you need to provide. More advanced themes can optionally include more HTML layouts to override the default GoodHuddle ones. If you don't provide an ovveride, GoodHuddle provides defaults that look fine in most cases. 

To override additional layouts simply include them in the ZIP bundle in the appropriate place under `layouts`. For example these are some of the common layouts for blog posts that themes often choose to override:

```sh
/layouts/blog/default-blog.hbs
/layouts/blog/post/default-blog-post.hbs
```

A complete list of layouts than can be overridden and sample seed files for each will be available here soon. 
 

## Including images, stylesheets and other resources

You can include any resources in your theme that you like, including images, CSS files and even additional custom JavaScript libraries. GoodHuddle places very few restrictions on this. 

These resources should be placed under the `resources` directory in your theme but you can use whatever sub-directories you like under that (such as '/resources/images' or '/resources/css'). 

For example `resources/css/theme.css` is a good place to put the default stylesheet for your theme. You would then be able to reference this stylesheet in your `default-layout.hbs` (or any other layout file), using: 

```html
<link href="/resources/css/theme.css" rel="stylesheet"/>
```

## The theme configuration file (`site.xml`)

The `site.xml` file must exist in the base of your theme ZIP. It is a simple XML configuation file, and should follow this structure:

```xml
<theme>
    <id>mytheme</id>
    <name>My Theme</name>
    <description>Just a theme that I made.</description>
</theme>
```

This structure is fairly self-explanatory, just replace the contents with the details of your custom theme. This file will likely be extended to include more fields in future versions of GoodHuddle as more advanced theming options are added. 

## Creating a thumbnail for your theme

Once your theme is complete, you should take a screenshot that will be be used as a thumbnail to help people recognise your theme when seeing it in a list. 

One nice way to do this is to use the Chrome developer tools to emulate a device with a 1024x768 px 
screen, take a screenshot, crop it and resize it to *460 x 290px*.

Save this thumbnail as `thumbnail.png` into the base directory of your theme's ZIP file (i.e. alongside `site.xml`).


## Uploading a theme

todo


## Contributing your theme back to the GoodHuddle community

todo





--------
stuff todo


```sh
/site.xml
/thumbnail.png
/resources/js/main.js
/resources/css/theme.css
/layouts/blog/post/default-blog-post.hbs
/layouts/blog/default-blog.hbs
/layouts/page/default-page.hbs
/layouts/default-layout.hbs
```

### Deploying a theme

Themes archives are placed into a directory called `gh-theme-library` inside
the root of a GoodHuddle deployment. The theme archive must be named 
`theme.zip`, the thumbnail `thumbnail.png`, and the directory should have
the same name as the theme's ID. Also placed in that directory is a copy
of the theme's thumbnail image and `site.xml`. These two files describe and 
illustrate the theme and the information in them is seen by GoodHuddle 
huddle admins when selecting a new theme for their huddle.

For example, for a theme with ID `mytheme` would have the following 
directories and files:

```sh
$ ls -lh goodhuddle/gh-theme-library
total 24K
drwxr-xr-x 2 huddler dan 4.0K Oct 21 09:33 mytheme

$ ls -lh goodhuddle/gh-theme-library/mytheme
total 368K
-rw-r--r-- 1 huddler dan  359 Oct 16 22:22 site.xml
-rw-r--r-- 1 huddler dan 301K Oct 16 22:22 theme.zip
-rw-r--r-- 1 huddler dan  51K Oct 16 22:22 thumbnail.jpg
```

# Using the theme 'seed'

The theme seed project can't be obtained by cloning this repository. The
theme skeleton is found in the `theme-seed` directory. The theme itself
is in `theme-seed/src`.

## First steps

1. Edit `site.xml` to add your theme's ID, name and description.
2. Edit `deploy.sh` (if you want to use it).

## Getting the needed components

The mandatory components can be automatically download with bower.

1. Make sure `bower` is installed. It's easiest to install `node.js`
and run `npm install -g bower`.
2. In `src` run `bower install`.

## Customising Bootstrap

The seed project supports creating a custom version of bootstrap.css by
editing the `variables.less` file and running the `rebuild_bootstrap.sh`
script from within the `src` directory. **Before you do that** however, make
sure the Bootstrap build system in installed by following the instructions
in `src/README.md`.

Customising bootstrap is optional, but if you  don't set it up you will have 
to modify the `build.sh` convenience script to remove that step.

## Editing templates, CSS, etc.

Edit the `.hbs` files (under `layouts`), `variables.less` and `resources/css/theme.css` as required to create your theme. Also add any
extra Javascript files under `resources/js`. Ensure they are all linked
in `default-layout.hbs`.

A good workflow if you have a local GoodHuddle instance installed is to 
initially install the theme early on, and then in your huddle's area under 
`gh-data/themes` remove the installed theme's directory (this
directory's name will numeric, like `5` &mdash; pick the highest number 
and that will be the current theme)  and symlink your development `src` 
directory there instead (with the same numeric name).
That way you can view your huddle and simply refresh a page 
whenever you want to check the progress of your theme, without needed in 
re-install the theme each time.

## Deploying

Once your theme is complete, you should take a screenshot that will be be
used as a thumbnail in the final package. One nice way to do this 
is to use Chrome developer tools to emulate a device with a 1024x768 px 
screen, take a screenshot, crop it and resize it to 460 x 290px.

The is a `deploy.sh` script that may or may not be of use. **It must be  edited
before use**.  It will build and deploy your theme in one easy step.
