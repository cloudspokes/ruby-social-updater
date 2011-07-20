# Bullhorn

Bullhorn is a simple application for posting to multiple social
networks.

It is available [on Heroku](http://bullhorn.heroku.com/).

## Configuring Applications

You must set environment variables for the various keys and secrets
`or the various social providers. The pattern is `PROVIDERNAME\_KEY` and 
`PROVIDERNAME\_SECRET`. If you're using [Pow](http://pow.cx) you can set
this up like so in a `.powenv` file in your project directory:

    export TWITTER_KEY=keygoeshere
    export TWITTER_SECRET=keygoesher
    export FACEBOOK_KEY=
    export FACEBOOK_SECRET=
    export LINKEDIN_KEY=
    export LINKEDIN_SECRET=

## Zero Persistence as a Feature

Bullhorn does not store **anything** in a remote database. Instead it
simply sets cookies with the appropriate token data encoded in them and
utilized those cookies automatically if they're present. There's no
database to maintain, no worries about external security or accidental
cross-posting. A user only has access to accounts that they have
authorized personally on their machine. There is also a one-click way to
destroy these cookies, cleaning out the system for use on something like
a public machine.
