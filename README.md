<h1 align="center"><img src="https://github.com/octree-gva/meta/blob/main/decidim/static/header.png?raw=true" alt="Decidim - Octree Participatory democracy on a robust and open source solution"></h1>
<h4 align="center">
    <a href="https://www.octree.ch">Octree</a> |
    <a href="https://octree.ch/en/contact-us/">Contact Us</a> |
    <a href="https://blog.octree.ch">Our Blog (FR)</a><br/><br/>
    <a href="https://decidim.org">Decidim</a> |
    <a href="https://docs.decidim.org/en/">Decidim Docs</a> |
    <a href="https://meta.decidim.org">Participatory Governance (meta decidim)</a><br/><br/>
    <a href="https://matrix.to/#/+decidim:matrix.org">Decidim Community (Matrix+Element.io)</a>
</h4>


<br/><br/>
This app is a Ruby on Rails app running [Decidim](decidim.org) for [HES-SO Valais/Wallis](https://www.hevs.ch/de/intro), the official participatory platform for the HES-SO.

> The HES-SO Valais-Wallis has over 2,800 students and is made up of five schools: School of Engineering, School of Management, School of Social Work, School of Health Sciences, School of Arts.

This app uses Octree's Decidim version, used for all Octree projects.

# Infrastructure

This application run on Infomaniak Jelastic nodes, [a green host that does his best for the ecology](https://www.infomaniak.com/en/ecology). This application is thus running in swiss only data-center, optimized to have lowest carbon footprint possible.

We serve this Ruby On Rails instance with the following infrastructure: 

- A postgres database to store data.
- A redis database to cache and enqueue asycronous tasks, like sending emails
- An puma webserver to serve Decidim
- A sidekiq webworker to trigger asynchronous tasks of Decidim


# Docker

A docker image is used for deployment, the docker image is ready for production, with some common configurations for RoR production images. The docker image includes:

- ImageMagick configurations, to avoid ImageTragick issues on image manipulations and avoid Server-side interaction (see [https://thoughtbot.com/blog/paperclip-is-vulnerable-to-the-imagetragick-vulnerability](https://thoughtbot.com/blog/paperclip-is-vulnerable-to-the-imagetragick-vulnerability) and [https://imagetragick.com/](https://imagetragick.com/) for references)
- Non-root user and group to run the puma application (see docker docs [https://docs.docker.com/engine/install/linux-postinstall/](https://docs.docker.com/engine/install/linux-postinstall/) as references, and [https://engineering.bitnami.com/articles/why-non-root-containers-are-important-for-security.html#:~:text=So why would you do,on your server%2C for example](https://engineering.bitnami.com/articles/why-non-root-containers-are-important-for-security.html#:~:text=So%20why%20would%20you%20do,on%20your%20server%2C%20for%20example).)


# Core Customizations

This app uses an Octree version of Decidim, where we do as few changes as possible to stay near the main branch. This instance does not have any divergence from the main branch of the open source repository Decidim. 

<br /><br />
<h4 align="center">
    <br /><br />
    <img src="https://github.com/octree-gva/meta/blob/main/decidim/static/participer_hevs/mobile_participer_hevs.png?raw=true" /><br /><br />
    <img src="https://github.com/octree-gva/meta/blob/main/decidim/static/participer_hevs/desktop_participer_hevs.png?raw=true" /><br /><br />
</h4>

<br /><br />

<p align="center">
    <img src="https://raw.githubusercontent.com/octree-gva/meta/main/decidim/static/octree_and_decidim.png" height="90" alt="Decidim Installation by Octree" />
</p>
