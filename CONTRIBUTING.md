# Contributing to Open Source Friday

Want to contribute to Open Source Friday? That's great! Here are a couple of guidelines that will help you contribute. Before we get started: Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md) to ensure that this project is a welcoming place for **everyone** to contribute to. By participating in this project you agree to abide by its terms.

## Contribution workflow

* Fork the project.
* Make your feature addition or bug fix.
* Send a pull request. Bonus points for topic branches.

## Setup instructions

You can find instructions to get setup in our [README](README.md#getting-started).

## Translation

* Fork the project.
* Clone your fork to your machine.
* Create a new branch for your translation work.
* Copy `_data/locales/en.yml` to target locale file e.g. `_data/locales/es.yml`.
* Create a new folder in the repository root e.g. `es/`.
* Copy `businesses.html`, `index.html` and `maintainers.html` from the repository root into the new folder e.g. `es/businesses.html` etc.
* Edit the `lang: en` to be the correct language in the new `businesses.html`, `index.html` and `maintainers.html` files e.g. `lang: es`
* Translate messages in new locale file and use `script/server` to verify they are displayed correctly.
* Send a pull request.

## Reporting a bug

So you've found a bug, and want to help us fix it? Before filing a bug report, please double-check the bug hasn't already been reported. You can do so [on our issue tracker](https://github.com/github/opensourcefriday/issues?q=is%3Aissue+is%3Aopen+label%3Abug). If something hasn't been raised, you can go ahead and create a new issue with the following information:

* On which page did the error happen?
* How can the error be reproduced?
* If possible, please also provide an error message or a screenshot to illustrate the problem

If you want to be really thorough, there is a great overview on Stack Overflow of [what you should consider when reporting a bug](http://stackoverflow.com/questions/240323/how-to-report-bugs-the-smart-way).

It goes without saying that you're welcome to help investigate further and/or find a fix for the bug. If you want to do so, just mention it in your bug report and offer your help!

## Additional info

Especially if you're a newcomer to Open Source and you've found some little bumps along the way while contributing, we recommend you write about them. [Here](https://medium.freecodecamp.com/new-contributors-to-open-source-please-blog-more-920af14cffd)'s a great article about why writing about your experience is important; this will encourage other beginners to try their luck at Open Source, too!
