# How to build a custom GoodHuddle Theme

## About themes

Themes are used give GoodHuddle site a distinct look and feel. Custom themes
can be produced and added to a GoodHuddle instance's library to allow huddle
admins to change their huddle's theme.

### The theme package file structure

Themes packaged into ZIP archives containing a `site.xml` configuration file,
a thumbnail image, and the files it needs to define the page layouts and 
resources (images, CSS, Javascript, etc) used by the theme.

A theme archive must contain the following files and directories:

```sh
/site.xml
/thumbnail.png
/layouts/default-layout.hbs
```

The `default-layout.hbs` file is the main template that wraps all pages 
in a huddle - theoretically you could leave this out [**needs checking], 
but then it's unlikely your theme would do much. All templates use [Handlebars](http://handlebarsjs.com/) templating and have the suffix
`.hbs`.

Other specific templates can be added to override the default GoodHuddle
ones, simply by adding the templates in the appropriate place under `layouts`:

```sh
/layouts/blog/default-blog.hbs
/layouts/blog/post/default-blog-post.hbs
/layouts/page/default-page.hbs
```

These templates are used for various components of the huddle, such as 
normal pages (`default-page.hbs`), the blog feed (`default-blog.hbs`)
and individual blog posts (`default-blog-post.hbs`).

By convention, resources or assets need by the theme are placed under the
`resources` directory. For example:

```sh
resources/css/theme.css
```

As a final example, a theme ZIP archive might have the following 
entries:

```sh
/site.xml
/resources/js/main.js
/resources/css/theme.css
/thumbnail.png
/layouts/blog/post/default-blog-post.hbs
/layouts/blog/default-blog.hbs
/layouts/page/default-page.hbs
/layouts/default-layout.hbs
```

## The theme configuration file (`site.xml`)

`site.xml` is a simple configuation file, with contents similar to this:

```xml
<theme>
    <id>mytheme</id>
    <name>My Theme</name>
    <description>Just a theme that I made.</description>
</theme>
```

This content are fairly self-explanatory. However, it is important that
the `id` matches the directory it is deployed to under `gh-theme-library` 
&mdash; see *Deploying a theme* below.

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
