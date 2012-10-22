# Data Format

## Items

Items are persisted in a MongoDB collection called `items`, with insecure data stored in plain text, and secure data stored as an encrypted blob in the `data` attribute.

    {
      id: ObjectId("…"),
      title: "GitHub",
      data: "[JSON HASH, ENCRYPTED WITH RANDOM KEY]"
    }

The data attribute is encrypted using a random key generated on the client.

## Teams

Items are persisted in a MongoDB collection called `teams`.

    {
      id: ObjectId("…"),
      name: "GitHub"
    }

Members are added to teams by inserting into the MongoDB collection called `memberships`.

    {
      team_id: ObjectId("…"),
      user_id: ObjectId("…"),
      key: "[RANDOM KEY ENCRYPTED WITH USER'S PUBLIC KEY]"
    }

The key is randomly generated on the client of the user who creates the team and then encrypted with the user's public key. Adding another member to the team is just a matter of an existing team member decrypting the team key with their private key and re-encrypting it with the new member's public key.

## Sharing

### Individuals

When an item is created, the randomly generated item key is encrypted with the creator's public key and persisted in the `shares` collection.

    {
      item_id: ObjectId("…"),
      user_id: ObjectId("…"),
      key: "[RANDOM KEY ENCRYPTED WITH USER'S PUBLIC KEY]"
    }

Sharing an item with another user is as simple as decrypting the *item key* with your own private key and re-incrypting it with their public key.

### Teams

To share an item with a team, a client decrypts the item key and team key with their private key, and then encrypts the item key with the decrypted team key. The resulting key is persisted in the `shares` collection:

    {
      item_id: ObjectId("…"),
      team_id: ObjectId("…"),
      key: "[RANDOM KEY ENCRYPTED WITH TEAM'S KEY]"
    }
