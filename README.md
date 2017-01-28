# IoT communication: Electric Meter request Automated Drone for Solar panel inspections Yayyy!

----

## What do we use?

**Ethereum**, **Oraclize**, AWS/**IPFS**/SWARM (for hosting), BlockoneID for permission
(in bold those that are already supported)

## {Foo Baar}: how does it work?

The Solar Panel is linked to a electric meter that is connected to the Ethereum blockchain.


The drone is resting on a ground control station that is connected to the Ethereum blockchain.


When the meter detects an unusual loss in output it request an intervention from the drone by sending a transaction to an Ethereum Smartcontract:

* if the meter's Ethereum address has been previously approved, 

* and if the drone is not yet in flight, 

* and if the flying conditions are alright

Then the smartcontract announces a public event containing  **flight request accepted** and the **Ethereum address** of the meter.

The ground control sees this event and load the corresponding flight plan for this Ethereum address (thus no GPS coordinate are published in the blockchain).

The flight plan is a return trip including a picture of the solar plan. As it lands back, the ground control gets the picture and upload it on IPFS, Swarm, AWS, mail service... 

Finally, the ground control send a transaction to the smart contract containing a pointer to where the file is hosted. 

The drone is now available for a new request and the dirtyness of the solar panel can be assessed by another party.


### Hey, since we will have a growing public database for dirty panels, what about doing some deeplearning on that? Oh, boy!!! we
### We could had another IoT reacting to the dirtyness, or publish a bounty contract for cleaning... to the mo0n!

## Tests:

Deploy Allowed : OK. Allowed functions: OK!


Deploy Drone : OK. Drone functions: OK! Oraclize callback giving the windspeed is working like charm.

...

All good!!