var fs = require('fs');
var net = require('net');
var mdns = require('mdns2');
var extend = require('util')._extend;

var requests = {
  Ping: 1,
  Pong: 2,
  GetPlatformRequest: 3,
  GetPlatformResponse: 4
};

var buildRequest = function (type, platform) {
  var message = {};  
  if (type == requests.GetPlatformRequest) {
    message["platform"] = extend({}, platform);
  }
  message["messageType"] = type + 1;
  message["status"] = true;
  message["error"] = "";
  
  return message;
};

// Create servers
var createServer = function (platform) {

  // advertise server
  var ad = mdns.createAdvertisement(new mdns.ServiceType(['uctrl', 'tcp']), platform.port)
  ad.start();

  // Start a TCP Server
  net.createServer(function (socket) {

    // Handle incoming messages from clients.
    socket.on('data', function (data) {
      console.log(socket.remoteAddress + ":" + socket.localPort + ">" + data);

      data = JSON.parse(data);
      socket.write(JSON.stringify(buildRequest(parseInt(data.messageType, 10), platform)));
    });
   
    socket.on('error', function (err) {
      if(err.code == "ECONNRESET") console.log("Connection ended furiously");
    }); 

    socket.on('end', function () {
      console.log("Connection ended");
    }); 
  }).listen(platform.port);
   
  console.log("Server running on port " + platform.port + "\n");  
};


// System parsing
var system;
fs.readFile('../uCtrlDesktop/data.json', 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  system = JSON.parse(data);
  system.platforms.forEach(createServer);
});
