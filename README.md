# MobyLog

For use with https://github.com/mobyinc/MobyLog

## Installation

* Add package
* As early as possible, call init with the server endpoint `MobyLog().init('https://my-logging-server', http.Client());
* Set user once known `MobyLog.setUser(userIdentifier)`
* Track screens and events

### Basic event logging

`MobyLog().screen('home');`

`MobyLog().event('logout');`

## Logging with info or data

`info` argument may be any string value
`data` may be any Map data serializable to JSON

`MobyLog().event('toggle', info: 'primary', data: { 'status': 'on' });`

