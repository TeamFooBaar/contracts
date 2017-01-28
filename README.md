# contracts

ABI before truffle

Allowed

[{"constant":false,"inputs":[],"name":"register","outputs":[],"payable":true,"type":"function"},{"constant":false,"inputs":[],"name":"withdrawfunds","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"changeOwner","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_member","type":"address"}],"name":"supprAllowed","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"_member","type":"address"}],"name":"isAllowed","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"AllowedList","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_member","type":"address"},{"indexed":false,"name":"_description","type":"uint256"}],"name":"AllowedListLog","type":"event"}]

Drone

[{"constant":false,"inputs":[{"name":"_newDroneStation","type":"address"}],"name":"changeDroneStation","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"currentDestination","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"myid","type":"bytes32"},{"name":"result","type":"string"}],"name":"__callback","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"myid","type":"bytes32"},{"name":"result","type":"string"},{"name":"proof","type":"bytes"}],"name":"__callback","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"APIURL","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"droneStation","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"}],"name":"requestFlightOwner","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_newAPIURL","type":"string"}],"name":"changeAPIURL","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_newAllowed","type":"address"}],"name":"changeAllowed","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"changeOwner","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_uploadedTo","type":"string"}],"name":"resetState","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"requestFlight","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"myid","type":"bytes32"},{"name":"result","type":"int256"}],"name":"__callback","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"resetStateOwner","outputs":[],"payable":false,"type":"function"},{"inputs":[{"name":"_droneStation","type":"address"},{"name":"_allowed","type":"address"},{"name":"_APIURL","type":"string"}],"payable":false,"type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"to","type":"address"},{"indexed":false,"name":"acceptedOrNot","type":"string"}],"name":"flightRequest","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"to","type":"address"},{"indexed":false,"name":"uploadedTo","type":"string"}],"name":"flightLog","type":"event"}]


Tests:

Deploy Allowed : OK.
function register : OK.
funciton withdrawfunds : not OK
