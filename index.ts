import express from "express";
import QRCode from "qrcode";

const app = express();

app.use(function (req, res) {
  if (!req.path) {
    res.sendStatus(404);
    return;
  }

  const path = req.path.substring(1);

  res.status(200);
  res.setHeader("content-type", "image/png");
  QRCode.toFileStream(res, path, { scale: 16, margin: 1 });
});

app.listen(80);
