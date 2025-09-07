# qrcode

A small GCP function for generating QR codes

## Requirements

* A GCP service connected to this repository
* Node.js 22 or greater

## Usage

Provide a query parameter of URI encoded `data` to the function, e.g.

```
https://<function-address>?data=<uri-encoded-data>
```
