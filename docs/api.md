# Discord Request API

## Standard Headers
- authorization: str
- auth-key: str
- legacy: bool

## GET
### id
Gets a discord id for the given player
- url: /id
- body: {}
- headers: {name: str, nick: str}
- response: {id: str}

## POST
### mute
Sets the mute status for a given player
- url: /mute
- body: {id: str, status: bool}
- headers: {}
- response: {}