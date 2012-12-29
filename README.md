# Swordfish [![Build Status](https://secure.travis-ci.org/github/swordfish.png)](http://travis-ci.org/github/swordfish)

Swordfish is an experiment in building a group-optimized password management app. It is currently very alpha. [Browse all the issues](https://github.com/github/swordfish/issues?milestone=) to see what features are planned.

![mockup](http://cl.ly/image/472B0N460j2I/content)

## Is it secure?

Storing passwords on a server might seem like filling a lake in Alaska with honey and expecting to keep bears out. I don't think it's like that. Why?

Even if an attacker gets access to your server or database, all secure items are encrypted client side. The server has no idea what it is storing and no way of decrypting it.

When you sign up, a RSA public/private keypair is generated in your browser. All sensitive data is encrypted with your private key, which is password-protected and never transferred to the server. No sensitive data is ever transmitted over the wire unless it is encrypted with secrets only available on the client.

## Recommended Reading

* [Why passwords have never been weaker—and crackers have never been stronger](http://arstechnica.com/security/2012/08/passwords-under-assault/) - A great article about password cracking techniques and the implications for choosing strong passwords.
* [JavaScript Cryptography Considered Harmful](http://www.matasano.com/articles/javascript-cryptography/) - A thoughtful critique of JavaScript encryption, discussed in [#28](https://github.com/github/swordfish/issues/28).
* [A JavaScript Implementation of TLS](http://digitalbazaar.com/2010/07/20/javascript-tls-1/) - The background of [Forge](https://github.com/digitalbazaar/forge/blob/master/README.md), the encryption library used by Swordfish.
* [Web Cryptography API](http://www.w3.org/2012/webcrypto/WebCryptoAPI/) - A draft W3C proposal for a JavaScript cryptography API. If all goes well, this will eventually replace Forge for all of the cryptography in Swordfish.
