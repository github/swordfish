# Data Format

## Items

Items are persisted in a MongoDB collection called `items`, with insecure data stored in plain text, and secure data stored as an encrypted blob in the `data` attribute.

    {
      id: ObjectId("…"),
      title: "GitHub",
      data: "[JSON HASH, ENCRYPTED WITH RANDOM KEY]"
    }

The data attribute is encrypted using a random key generated on the client.

## Shares

When an item is created, the randomly generated item key is encrypted with the creator's public key and persisted in the `shares` collection.

    {
      item_id: ObjectId("…"),
      user_id: ObjectId("…"),
      key: "[RANDOM ITEM KEY ENCRYPTED WITH USER'S PUBLIC KEY]"
    }

Sharing an item with another user is as simple as decrypting the *item key* with your own private key and re-incrypting it with their public key.