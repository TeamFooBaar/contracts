pragma solidity ^0.4.6;

import "Owned.sol";
import "authorization/AbstractAuthorization.sol";
import "usingOraclize.sol";

contract Drone is Owned, usingOraclize {

  // List of registred destination by public key
  // if a key is registred AND if the flying conditions are ok
  // than it will trigger the flight instructions for the said public key
  // event request for flight (flightRequest)
  // event for uploaded file (flightLog)
  // Owner could be a DAO so no IRL interaction is needed
  // FUll blockchain t0o the m000n
  // API ? https://www.wolframalpha.com/input/?i=wind+zug


                 /* stuff and mapping  */

  address public droneStation;
  AbstractAuthorization AllowedDroneCaller; //where the contract Allowed is
  //droneStation is a key controled by the node at the station of the droneStation
  // this node will also handle uploading the pictures taken by the drone 
  address public currentDestination; //currentDestination acts as the state of the drone
  string public APIURL;
  bool internal _isAllowed;

                /*event for the logs*/

  event flightRequest(address to, string acceptedOrNot);
  // to is the address which relate to the flight instructions
  // accepted will obv use inFlight
  event flightLog(address to, string uploadedTo);
  // after the flight droneStation will upload the picture it tooks
  // for deeplearning purposes, the picture will be stored to constitute a training set!!!


              /* droneStation exclusivity */

  modifier groundOnly() {
    if (msg.sender != droneStation) throw;
    _;
  }

  function Drone(address _droneStation, address _allowed, string _APIURL ) {
    droneStation = _droneStation;
    AllowedDroneCaller = AbstractAuthorization(_allowed);
    APIURL = _APIURL;
    currentDestination = 0;
  } 


  /* UPDATABILITY */
  function changeDroneStation(address _newDroneStation) ownerOnly {
    // this part about ownership, who can change etc. has to be tuned
    // owner can be a multisig wallet for example
    droneStation = _newDroneStation;
  }

  function changeAllowed(address _newAllowed) ownerOnly {
    // this part about ownership, who can change etc. has to be tuned
    // owner can be a multisig wallet for example
    AllowedDroneCaller = AbstractAuthorization(_newAllowed);
  }

  function changeAPIURL(string _newAPIURL) ownerOnly {
    // this part about ownership, who can change etc. has to be tuned
    // owner can be a multisig wallet for example
    APIURL = _newAPIURL;
  }

              /* METHODS */
  //for the moment flight requests are instantaneous 
  function requestFlight() payable {
    //no request if already a flight is already in progress
    if (currentDestination != 0) throw;
    //check if msg.sender is Allowed
    _isAllowed = AllowedDroneCaller.isAllowed(msg.sender);
    if (!_isAllowed) throw; 
    //check if flight conditions are good
    currentDestination = msg.sender;
    oraclize_query("URL", APIURL);
  }

  function requestFlightOwner(address _to) ownerOnly {
    //no request if already a flight is already in progress
    if (currentDestination != 0) throw;
    //check if destination is Allowed
    _isAllowed = AllowedDroneCaller.isAllowed(_to);
    if (!_isAllowed) throw; 
    //check if flight conditions are good
    currentDestination = _to;
    oraclize_query("URL", APIURL);
  }

  //¤¤¤¤¤¤¤¤¤¤¤¤ CHAINSAWING STRING INTO UINT *¤¤¤¤¤¤¤¤¤¤¤
  // Copyright (c) 2015-2016 Oraclize srl, Thomas Bertani
  function parseInt(string _a, uint _b) internal returns (uint) {
    bytes memory bresult = bytes(_a);
    uint mint = 0;
    bool decimals = false;
    for (uint i = 0; i < bresult.length; i++) {
      if ((bresult[i] >= 48) && (bresult[i] <= 57)) {
        if (decimals) {
          if (_b == 0) break;
            else _b--;
        }
        mint *= 10;
        mint += uint(bresult[i]) - 48;
      } else if (bresult[i] == 46) decimals = true;
    }
    return mint;
  }

              /* Oracle callback */ 
                  //"json(http://weathers.co/api.php?city=Zug).data.wind
      
  function __callback(bytes32 myid, string result) {
    if (msg.sender != oraclize_cbAddress()) throw;
    uint _windSpeed = parseInt(result, 0);
    if (_windSpeed > 50){ // level 7 on the Beaufort scale : you should go sailing eaither
     flightRequest(currentDestination, "refused");
     currentDestination = 0;
     return;
    }
    flightRequest(currentDestination, "accepted");
  }
  
  function resetState(string _uploadedTo) groundOnly {
    flightLog(currentDestination, _uploadedTo);
    currentDestination = 0;
  }
  function resetStateOwner() ownerOnly {
    flightLog(currentDestination, "state reseted by owner");
    currentDestination = 0x0000000000000000000000000000000000000000;
  }
}