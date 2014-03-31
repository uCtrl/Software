var net = require('net');
var mdns = require('mdns2');

port = 5000;

devices = {
  "id": 234234,
  "devices": [
    {
      "id": 345658,
      "maxValue": 100.000000,
      "minValue": 0.000000,
      "precision": 0,
      "type": 1,
      "unitLabel": "celcius",
      "name": "Temperature",
      "scenarios": [
        {
          "id": 1782103622,
          "name": "Semaine",
          "tasks": [
            {
              "id": 1782103623,
              "name": "newTask1",
              "status": "20%",
              "conditions": [
                {
                  "id": 1782103624
                }
              ]
            },
            {
              "id": 1782103626,
              "name": "newTask1",
              "status": "13%",
              "conditions": [
                {
                  "id": 1782103624
                }
              ]
            }
          ]
        }
      ]
    }
  ]
};

// advertise server
var ad = mdns.createAdvertisement(new mdns.ServiceType(['uctrl', 'tcp']), port)
ad.start();

// Start a TCP Server
net.createServer(function (socket) {

  // Handle incoming messages from clients.
	socket.on('data', function (data) {
		console.log(socket.remoteAddress + ">" + data);
  	socket.write(JSON.stringify(devices));
  });
 
	socket.on('end', function () {
  	console.log("Connection ended");
	});
 
}).listen(port);
 
console.log("Server running on port " + port + "\n");
