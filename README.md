hiera-eyaml-p7b
===============

Adressing [TomPoulton/hiera-eyaml#105](https://github.com/TomPoulton/hiera-eyaml/issues/105)

This is a plugin encryptor for the hiera-eyaml project (hosted https://github.com/TomPoulton/hiera-eyaml/).
It is a OpenSSL PKCS#7 encryptor like the original encryptor in hiera-eyaml but with the ability to use multiple keys.

Unfortunatly it needs a [patched version of hiera-eyaml](https://github.com/h-svab/hiera-eyaml/commit/1984a3fb01ee3ef30a11c8312e3bcc97973d3a35).

### Usage:

```
$ gem install hiera-eyaml-p7b
```

Then see hiera-eyaml documentation for how to use the eyaml tool to encrypt using the 'P7B' encryption_type.

### Config:
```
---
encrypt_method: 'p7b'
p7b_private_key: '/home/user/.eyaml/ssl/user_private_key.pem'
p7b_public_key:  '/home/user/.eyaml/ssl/user_public_key.pem'
p7b_public_keys: '/home/user/.eyaml/ssl/user_public_key.pem,/home/user/.eyaml/ssl/server_public_key.pem'
```

Authors
=======

- [Harald Svab](https://github.com/h-svab)
