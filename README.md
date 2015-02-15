**NOTE: This repository is no longer supported or updated by GitHub. If you wish to continue to develop this code yourself, we recommend you fork it.**

# Swordfish [![Build Status](https://secure.travis-ci.org/github/swordfish.png?branch=master)](http://travis-ci.org/github/swordfish)

Swordfish was an experiment in building a group-optimized password management
app. It is unmaintained and is likely insecure.

## Recommended Reading

* [Why passwords have never been weaker—and crackers have never been stronger](http://arstechnica.com/security/2012/08/passwords-under-assault/) - A great article about password cracking techniques and the implications for choosing strong passwords.
* [JavaScript Cryptography Considered Harmful](http://www.matasano.com/articles/javascript-cryptography/) - A thoughtful critique of JavaScript encryption, discussed in [#28](https://github.com/github/swordfish/issues/28).
* [A JavaScript Implementation of TLS](http://digitalbazaar.com/2010/07/20/javascript-tls-1/) - The background of [Forge](https://github.com/digitalbazaar/forge/blob/master/README.md), the encryption library used by Swordfish.
* [Web Cryptography API](http://www.w3.org/2012/webcrypto/WebCryptoAPI/) - A draft W3C proposal for a JavaScript cryptography API. If all goes well, this will eventually replace Forge for all of the cryptography in Swordfish.
* [Megabad: A quick look at the state of Mega’s encryption](http://arstechnica.com/business/2013/01/megabad-a-quick-look-at-the-state-of-megas-encryption/) - Mega essentially uses the same approach as Swordfish: RSA keys for each user, coupled with a randomly generated key for AES encryption of each item.

## Working on Swordfish

Use the `bootstrap` script to get the environment set up.

    script/bootstrap

Now you will need to run the database migrations before you run the server.

    bundle exec rake db:create db:migrate

Finally you can start the application.

    script/rails s

Running the tests requires PhantomJS. If you're on Mac OS X you can use homebrew
to install this for you.

    brew install phantomjs

If you hack on Swordfish and end up adding or editing features you will want to
run the tests.

    bundle exec rake

Want to join the [core team](https://github.com/github/swordfish/blob/master/docs/core.md)?
