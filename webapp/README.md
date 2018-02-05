# VirtKick. Cloud made easy.

[![GPA](https://img.shields.io/codeclimate/github/virtkick/virtkick-webapp.svg?style=flat-square)](https://codeclimate.com/github/virtkick/virtkick-webapp)
[![Build status](https://img.shields.io/travis/virtkick/virtkick-webapp.svg?style=flat-square)](https://travis-ci.org/virtkick/virtkick-webapp)
[![Dependencies status](http://img.shields.io/gemnasium/virtkick/virtkick-webapp.svg?style=flat-square)](https://gemnasium.com/virtkick/virtkick-webapp)
[![Gratipay](https://img.shields.io/gratipay/Nowaker.svg?style=flat-square)](https://gratipay.com/Nowaker/)

VirtKick is a simple, open source orchestrator.
Managing virtual machines or Docker containers has never been easier.

That's the VirtKick web application. It provides a user interface and delegates virtualization-related tasks to the backend.

## Issues

Report bugs and feature requests in [virtkick](https://github.com/virtkick/virtkick) meta-project.

All the user and admin documentation is there too.

## Requirements

- [RVM](https://rvm.io/)
- Ruby 2.1 from RVM
- Linux or Mac
- [virtkick-webvirtmgr-backend](https://github.com/virtkick/virtkick-webvirtmgr-backend)

## One time setup

```
rvm get stable
rvm install 2.1
rvm use 2.1 --default
gem install bundler
```

## Development

#### Setup
```
alias x='bundle exec'
x install
x rake db:migrate
```

#### Start
In separate sessions:
```
x rails s
```
Run `INLINE=1 x rails s` to inline execute jobs instead of sending them to background.

```
x rake jobs:work
```

Now test with  `xdg-open http://0.0.0.0:3000/ # open a browser`



## Deployment

```
x rails s -e production
x ./bin/delayed_job -n 5 start
```

Environment variables:

- SECRET_KEY_BASE
- DEVISE_SECRET_KEY
- BUGSNAG_API_KEY - optional for [Bugsnag](https://bugsnag.com/)

Use `pwgen -sn 128` or `x rake secret` to generate secret keys.

## Contributing

See [CONTRIBUTING.md](https://github.com/virtkick/virtkick-website/blob/master/CONTRIBUTING.md). Thanks!


# Sponsors

- Tip us weekly with Gratipay: [![Donate with Gratipay](https://img.shields.io/gratipay/Nowaker.svg?style=flat-square)](https://gratipay.com/Nowaker/)
- One-time donate with PayPal: [![Donate with PayPal](https://raw.githubusercontent.com/virtkick/virtkick/master/paypal-donate.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=AGF4FPG7JZ7NY&lc=US)
- Or with Bitcoins: `1Nb7PxyNAKSNc6traXW4NPyPMhJA7PwXf8`
- [Become a corporate sponsor](https://www.virtkick.io/become-a-sponsor.html).

Thanks for your support!


# License

VirtKick, a simple orchestrator.
Copyright (C) 2014 StratusHost Damian Nowak

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see https://www.gnu.org/licenses/agpl-3.0.html.


# Trademark

The VirtKick name and logo are trademarks of Damian Nowak.
You may not use them for promotional purposes,
or in any way that claims, suggests or looks like
there's a relationship or endorsement by VirtKick.

Other marks and names mentioned herein may be trademarks of their respective companies.
