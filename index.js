const functions = require('@google-cloud/functions-framework');
const QRCode = require("qrcode");

functions.http('qrcode', (req, res) => {
  res.status(200);
  res.setHeader('content-type', 'image/png');
  QRCode.toFileStream(res, req.query.data ?? "invalid", {scale: 16, margin: 1});
});
