# Let's Encrypt / Nginx / OpsWorks Chef Recepie

Recepie for custom nginx.conf file generation that supports Let's Encrypt SSL certificate for Rails apps

1. You need to edit your App settings to include custom chef recepies



<img width="931" alt="screen shot 2016-12-26 at 17 16 08" src="https://cloud.githubusercontent.com/assets/24574228/21484294/8aaf27fa-cb90-11e6-93ea-30267bc113ed.png">

You need to change 'Use Custom Chef cookbooks' to "Yes"

Put this value as "Repository URL"

```
git@github.com:kodius/kodius-chef-recepies.git
```

So it looks like this:

<img width="982" alt="screen shot 2016-12-26 at 17 16 41" src="https://cloud.githubusercontent.com/assets/24574228/21484295/8ca5d518-cb90-11e6-83ed-2899cc914ec8.png">


2. Adding custom step in App setup

```
kodius-recepies::production_environment
```

It should look like this:

<img width="657" alt="screen shot 2016-12-26 at 17 25 20" src="https://cloud.githubusercontent.com/assets/24574228/21484296/8e801510-cb90-11e6-8d16-f8802e22d971.png">
