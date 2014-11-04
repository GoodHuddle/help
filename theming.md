# How to build a custom GoodHuddle Theme

## About themes

Themes are used to give a GoodHuddle website a distinct look and feel. 

Custom themes can be created and uploaded to your own Huddle to completely change the way your Huddle website looks. From colours, to fonts, to the entire layout and positioning of headers, footers and menus. Everything in a GoodHuddle website is completely customisable. 
 
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

The `default-layout.hbs` file is the base layout for your theme. This a HTML template file that defines the outer layout of your theme (i.e. the header, menu, footer, etc). 

The `.hbs` extension is just to indicate this layout uses Handlebars. We'll explain more about this below. 

## Using the `seed` theme

The theme seed project can be obtained by cloning this repository. The
theme skeleton is found in the `theme-seed` directory. The theme itself
is in `theme-seed/src`.

-- more on this coming soon --


## Creating the `default-layout.hbs` file

The `default-layout.hbs` file is the core of your theme. It is really just a standard HTML file with a little bit of custom markup added to it to let GoodHuddle know how to use it.

For example, an extremely basic `default-layout.hbs` file could look like this: 

```html
<html>	
    <head>	
        {{#section "head"}}
            <title>{{huddle.name}}</title>	
            <link href="/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
        {{/section}}
    </head>	
    <body>	
        {{#section "content"}}
            Page content will go here
        {{/section}}
        
        {{#section "scripts"}}
            <script src="/lib/jquery/jquery.min.js"></script>
            <script src="/lib/bootstrap/js/bootstrap.min.js"></script>
        {{/section}}
    </body>	
</html>
```

Most of this is a bare bones HTML file. The bits of code inside the `{{ }}` blocks are the Handlebars tags that tell GoodHuddle which bits of the theme it can interact with. 

The `{{section "head"}}` tells GoodHuddle that this is the 'head' of the HTML file. GoodHuddle will add extra bits to this section (such as additional stylesheets the huddle needs) when this theme is used inside a Huddle. 

The "head" section includes a `<title>` element. You could hard code the name of your Huddle into this, however, just to demonstrate one of GoodHuddle's features, we've used the dynamic reference to `{{huddle.name}}`. When this theme is used inside a Huddle, that dynamic reference will be replaced with the name of the Huddle. If the users want to change the name, they simply edit their Huddle settings online instead of digging into the theme code. 

Also inside the "head" section, this includes a link to the default Bootstrap CSS stylesheet. Every huddle must include a link to Bootstrap for the pages to layout properly. You can either use this link, which points to the default, built-in version of Bootstrap provided by GoodHuddle, or you can include your own version inside the `resources` directory of your theme and reference that instead. 

The `{{section "content"}}` tells GoodHuddle where to put the page content. Everything between `{{section "content"}}` and `{{\section}}` will be replaced by the real content of the page when a person navigates to that page in the huddle. For example, a Huddle's 'home' page might replace this with a welcome message, whereas the 'about us' page might replace this with information about the people running the huddle.

The `{{section "scripts"}}` is similar to the "head" section. It tells GoodHuddle that this is where custom JavaScript links should be added to the theme. GoodHuddle will append it's own links to the ones in your theme as needed. 

This basic theme includes two links to built in JavaScript files. One is for JQuery and one is for Bootstrap. Each theme must include both of these libraries. Again, either the built in Huddle versions of these libraries can be used (as in this example), or you can include your own versiosn in the `/resources` directory and change these links to reference those instead.

There's really nothing more to layout files than that. You can take this example layout file and add as much HTML as you like. Move the content around, add a banner image up the top, change it however you like. 

## Including dynamic menus

Menus can be easily added as static HTML to your theme. For example you could edit our basic theme file above to look something like this: 

```html
<html>	
    ...
    <body>
        <!-- include a static menu -->
        <ul> 
            <li><a href="/home">Home</a></li>
            <li><a href="/about">About us</a></li>
            <li><a href="/contact">Contact Us</a></li>
        </ul>
        
        {{#section "content"}}
            Page content will go here
        {{/section}}
        ...
    </body>	
</html>
```

This kind of static menu is simple but it isn't very dynamic. If someone adds a new page, they will need to edit your theme. We want to avoid average users from getting into technical theme building stuff, so a better approach is to make your theme handle dynamic menus. 

GoodHuddle provides some predefined variables for creating menus dynamically from the Huddle's existing pages. This is how we would write the above code as a dynamic menu: 

```html
<html>	
    ...
    <body>
        <!-- include a static menu -->
        <ul> 
            {{#each menu.items}}
                <li><a href="{{url}}">{{label}}</a></li>
            {{/each}}
        </ul>
        
        {{#section "content"}}
            Page content will go here
        {{/section}}
        ...
    </body>	
</html>
```

Now a new menu link will be dynamically generated for each page in the Huddle. The users can edit their menu directly through their Huddle admin panel without needing to change any theme code. 

Menus can get more complicated than this. Many themes will want dynamic, multi-level menus that popup on mouseover and highlight the selected menu item. This is all possible in GoodHuddle - you can make your menu use whatever structure you like. We will create more detailed tutorials on all this but for now check out some of the existing themes for ways to do this. 

## Additional layouts

The `default-layout.hbs` file is the only layout you need to provide. More advanced themes can optionally include more HTML layouts to override the default GoodHuddle ones. If you don't provide an override, GoodHuddle provides defaults that look fine in most cases. 

To override additional layouts simply include them in the ZIP bundle in the appropriate place under `layouts`. For example these are some of the common layouts for blog posts that themes often choose to override:

```sh
/layouts/blog/default-blog.hbs
/layouts/blog/post/default-blog-post.hbs
```

A complete list of layouts than can be overridden (and sample seed files for each) will be available here soon. 
 
## Including images, stylesheets and other resources

You can include any resources in your theme that you like, including images, CSS files and even additional custom JavaScript libraries. GoodHuddle places very few restrictions on this. 

These resources should be placed under the `resources` directory in your theme but you can use whatever sub-directories you like under that (such as '/resources/images' or '/resources/css'). 

For example `resources/css/theme.css` is a good place to put the default stylesheet for your theme. You would then be able to reference this stylesheet in your `default-layout.hbs` (or any other layout file), using: 

```html
<link href="/resources/css/theme.css" rel="stylesheet"/>
```

Additionally, if you wanted to include an image in your website theme, you could include it under `resources/images/myimage.jpg`. To reference this image in your layout you would use:

```html
<img src="/resources/images/myimage.jpg">
```

The same process applies for including custom JavaScript files, and any other type of static resource you would like to include. A theme that contains a combination of custom JavaScript, images and layouts might have a directory strucure like this: 

```sh
/site.xml
/thumbnail.png
/resources/js/custom.js
/resources/css/theme.css
/resources/images/banner-image-1.jpg
/resources/images/banner-image-2.jpg
/layouts/default-layout.hbs
/layouts/blog/post/default-blog-post.hbs
/layouts/blog/default-blog.hbs
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

## Testing a theme locally

Building a theme is often an iterative proces. You want to make some changes, see how they look and then make some more changes. This can be a slow process if you have to ZIP and upload your theme each time. To make things quicker and easier, you can instead download and install the Huddle Theme SDK and use this to run your own test on your local computer. 

The steps for this are currently a little bit complex, but if you are editing a theme often, it is worth the investment of time:

0. Install Java from [http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html]()
0. Install PostgreSQL from [http://www.postgresql.org/]()
0. Download the latest release of the GoodHuddle from [http://tools.goodhuddle.com/release/huddle/latest/huddle.jar]()
0. In PostgreSQL create a new user called 'huddle' with password 'huddle' 
0. Start your local huddle by running ``java -jar huddle.jar`` from the command line
0. Open a web browser to [http://localhost:8080]() and fill in the setup form.
0. Log into the [Admin Console](http://localhost:8080/admin) and step through the setup wizard. Choose any theme as a starting point, it doesn't matter.
0. The theme you chose will have been installed in ``gh-data/theme/1`` - use this folder as your working directory for your theme. Copy your own theme files into this directory and edit as needed. 
0. Check your theme during the editing process by refreshing your browser [http://localhost:8080]().
0. When you are happy with your theme, make sure the ``site.xml`` and ``thumbnail.jpg`` are both how you want them, and then zip up this theme folder so it is ready to upload. 

## Uploading a theme

Once you are happy with your theme, you can upload it to your Huddle. To do this simply ZIP your theme files into a single package and then use your Huddle's admin portal to upload the theme.   

To zip up your theme files, you can use any zip program you like, including [WinZip](http://www.winzip.com/) or [7-Zip](http://www.7-zip.org/). Make sure you zip your files in such a way that ``site.xml`` and ``thumbnail.png`` are in the base folder of your theme.

On Mac, a command line zip tool comes installed by default. Use the following command line call from within the base directory of your theme:

```sh
zip -r theme.zip .
```

You can then upload the resulting ``theme.zip`` to you Huddle. If you haven't already got a Huddle yet, you can register for a free one now at http://goodhuddle.com.

If you already have your Huddle, login into your admin portal (you should have been emailed information on how to login when you signed up). Once logged in, navigate to the ``website`` section and choose ``Change Theme`` and then ``Upload``. Use the file chooser to select your zip file and your new theme will be instantly activated.  


## Contributing your theme back to the GoodHuddle community

If you have created a theme that you would like to contribute back to the community for other groups to benefit on, please let us know. We're working on a GoodHuddle theme marketplace where people will be able to buy and sell (or donate!) themes. In the meantime however, send us an email at info@goodhuddle.com to contribute your theme back to the community. 
