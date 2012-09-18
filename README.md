# Swordfish [![Build Status](https://secure.travis-ci.org/github/swordfish.png)](http://travis-ci.org/github/swordfish)

Swordfish is an experiment in builidng a group-optimized password management app. It is currently very alpha. [Browse all the issues](https://github.com/github/swordfish/issues?milestone=) to see what features are planned.

![mockup](http://cl.ly/image/472B0N460j2I/content)

## Is it secure?

Storing passwords on a server might seem like filling a lake in Alaska with honey and expecting to keep bears out. I don't think it's like that. Why?

Even if an attacker gets access to your server or database, all secure items are encrypted client side. The server has no idea what it is storing and no way of decrypting it.

When you sign up, a RSA public/private keypair is generated in your browser. All sensitive data is encrypted with your private key, which is password-protected and never transferred to the server. No sensitive data is ever transmitted over the wire unless it is encrypted with secrets only available on the client.

## Recommended Reading

[Why passwords have never been weaker—and crackers have never been stronger](http://arstechnica.com/security/2012/08/passwords-under-assault/)
A great article about password cracking techniques and the implications for choosing strong passwords.

[Javascript Cryptography Considered Harmful](http://www.matasano.com/articles/javascript-cryptography/)
A thoughtful critique of JavaScript encryption, discussed in #28.

[A JavaScript Implementation of TLS](http://digitalbazaar.com/2010/07/20/javascript-tls-1/)
The background of [Forge](http://github.com/digitalbazaar/forge/blob/master/README), the encryption library used by Swordfish.

## Contributing

If you find a security vulnerability:

1. **DO NOT POST ABOUT IT PUBLICLY**
2. Send an email to bkeepers@github.com with details about the security vulnerability.
3. After a fix has been released, a public announcement will be made giving all glory and honor to you.

If you find what looks like a bug:

1. Search the [mailing list](https://groups.google.com/group/swordfishapp) to see if anyone else had the same issue.
2. Check the [GitHub issue tracker](https://github.com/github/swordfish/issues) to see if anyone else has reported issue.
3. If you don't see anything, [create an issue](https://github.com/github/swordfish/issues/new) with information on how to reproduce the issue.

If you want to contribute an enhancement or a fix:

1. Fork the project on GitHub.
2. Make your changes with tests.
3. Commit the changes without making changes to the Rakefile, Gemfile, gemspec, or any other files that aren't related to your enhancement or fix.
4. Send a pull request.