require('array.prototype.find');

var fs = require('fs');
var net = require('net');
var mdns = require('mdns2');
var extend = require('util')._extend;

var filePath = '../uCtrlDesktop/data.json';

var messages = {
  Ping: 1,
  Pong: 2,
  GetPlatformRequest: 3,
  GetPlatformResponse: 4,
  SavePlatformRequest: 5,
  SavePlatformResponse: 6
};

var system;

var savePlatform = function(oldPlatform, newPlatform) {
  var indexOfPlatform = system.platforms.indexOf(system.platforms.find(
    function(element, index, array){
      return element.id === oldPlatform.id;
    }
  ));

  if(indexOfPlatform !== -1 ) {
    system.platforms.splice(indexOfPlatform, 1);
    system.platforms.push(newPlatform);
    var systemString = JSON.stringify(system, null, 2);
    fs.writeFile(filePath, systemString, function (err) {
      if (err) return console.log(err);
      console.log('File saved!');
    });
  }
};

var buildResponse = function (type, platform) {
  var message = {};  
  if (type === messages.GetPlatformRequest) {
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

      var messageType = parseInt(data.messageType, 10);

      if(messageType === messages.SavePlatformRequest) {
        savePlatform(platform, data.platform);
        platform = data.platform;
      }

      socket.write(JSON.stringify(buildResponse(messageType, platform)));
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
fs.readFile(filePath, 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  system = JSON.parse(data);
  system.platforms.forEach(createServer);
});
