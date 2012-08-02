# Swordfish

Swordfish is a group-optimized password management app.

![mockup](http://cl.ly/image/1R1Q0U3i1X19/content)

## Current status

It is currently very alpha. Some very basic features are working, but it is buggy and there is no support for authenticating users. See the [Alpha milestone](https://github.com/bkeepers/swordfish/issues?milestone=1&state=open) to see what is left to do before I consider it usable for a single user. [Browse all the issues](https://github.com/bkeepers/swordfish/issues?milestone=) to see what features are planned.

## Is it secure?

Storing passwords on a server might seem like filling a lake in Alaska with honey and expecting to keep bears out. I don't think it's like that. Why?

Even if an attacker gets access to your server or database, all secure items are encrypted client side. The server has no idea what it is storing and no way of decrypting it.

All items stored in a vault are encrypted with a *vault key*, which is randomly generated on the client when the vault is created and encrypted (currently with [AES](http://code.google.com/p/crypto-js/#AES) and a master password, eventually it will use [PKI](#12)). The encrypted vault key is stored on the server, but the password is not. No sensitive data is ever transmitted over the wire unless it is encrypted using secrets only available on the client.

## Contributing

If you find a security vulnerability:

1. **DO NOT POST ABOUT IT PUBLICLY**
2. Send an email to bkeepers@github.com with details about the security vulnerability.
3. After a fix has been released, a public announcement will be made giving all glory and honor to you.

If you find what looks like a bug:

1. Search the [mailing list](https://groups.google.com/group/swordfishapp) to see if anyone else had the same issue.
2. Check the [GitHub issue tracker](https://github.com/bkeepers/swordfish/issues) to see if anyone else has reported issue.
3. If you don't see anything, [create an issue](https://github.com/bkeepers/swordfish/issues/new) with information on how to reproduce the issue.

If you want to contribute an enhancement or a fix:

1. Fork the project on GitHub.
2. Make your changes with tests.
3. Commit the changes without making changes to the Rakefile, Gemfile, gemspec, or any other files that aren't related to your enhancement or fix
4. Send a pull request.