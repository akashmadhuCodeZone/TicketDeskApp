const { env } = require('process');

const target = env.ASPNETCORE_HTTPS_PORT ? `https://localhost:${env.ASPNETCORE_HTTPS_PORT}` :
    env.ASPNETCORE_URLS ? env.ASPNETCORE_URLS.split(';')[0] : 'https://localhost:7290/api';

const PROXY_CONFIG = [
  {
    context: [
      "/weatherforecast",
      "/login",
      "/userprofile",
      "/ticket",
      "/registeration",
      "/agent",
      "/customer"
    ],
    target,
    secure: false
  }
]

module.exports = PROXY_CONFIG;
