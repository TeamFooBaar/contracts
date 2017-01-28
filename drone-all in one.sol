pragma solidity ^0.4.6;
//using https://dapps.oraclize.it/browser-solidity/
import "https://github.com/oraclize/ethereum-api/oraclizeAPI_0.4.sol";
contract Owned {
  /* The owner of the contract can add members and transfer ownership.
     initial value is the contract creator */
  address public owner = msg.sender;
  modifier ownerOnly() {
    if (msg.sender != owner) throw;
    _;
  }

  /* transfer ownership */
  function changeOwner(address _newOwner) ownerOnly {
    owner = _newOwner;
  }
}
//PAYMENT SYSTEM WITH contract Withdraw
contract Allowed is Owned { 
  mapping(address => uint) public AllowedList;
  event AllowedListLog(address _member, uint _description);

  /* Check that a given address is on the Allowedlist*/
  function isAllowed(address _member) constant returns (bool){
   return AllowedList[_member] > now ;
  }

/* pay at least 1 ETH to be allowed for a year */
/* the 1 year and 1 ETH can of course be parameters */

function register() payable {
if (msg.value < 1 ether) throw;
addAllowed(msg.sender);
}
  /* addAllowed*/

  function addAllowed(address _member) internal {
    if (AllowedList[_member] > now) 
    AllowedList[_member] +=  31556926 ;  //31556926 seconds in a year
    AllowedList[_member] = now + 31556926 ;
    AllowedListLog(_member, AllowedList[_member]);
  }
    /* supprAllowed*/
  function supprAllowed(address _member) ownerOnly {
    AllowedList[_member] = 0;
    AllowedListLog(_member, 0);
  }
  /* withdraw funds*/
 function withdrawfunds() ownerOnly  {
     (new Withdraw).value(this.balance)();
 }
}
contract Withdraw {
   //safe withdraw?
   Withdraw ispayable;
function Withdraw() payable {
   selfdestruct(msg.sender);
}
}

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
Allowed AllowedDroneCaller; //where the contract Allowed is
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

modifier droneOnly() {
    if (msg.sender != droneStation) throw;
    _;
  }
function Drone(address _droneStation, address _allowed, string _APIURL ) {
    droneStation = _droneStation;
    AllowedDroneCaller = Allowed(_allowed);
    APIURL = _APIURL;
    //"json(http://weathers.co/api.php?city=Zug).data.temperature
    currentDestination = 0x0;

    } //initialize the droneStation address


/* UPDATABILITY */
function changeDroneStation(address _newDroneStation) ownerOnly {
    // this part about ownership, who can change etc. has to be tuned
    // owner can be a multisig wallet for example
    droneStation = _newDroneStation;
}
function changeAllowed(address _newAllowed) ownerOnly {
    // this part about ownership, who can change etc. has to be tuned
    // owner can be a multisig wallet for example
        AllowedDroneCaller = Allowed(_newAllowed);
}
function changeAPIURL(string _newAPIURL) ownerOnly {
    // this part about ownership, who can change etc. has to be tuned
    // owner can be a multisig wallet for example
        APIURL = _newAPIURL;
}


            /* METHODS */
//for the moment flight requests are instantaneous 
function requestFlight() {
    //no request if already a flight is already in progress
    if (currentDestination != 0x0) throw;
    //check if msg.sender is Allowed
    _isAllowed = AllowedDroneCaller.isAllowed(msg.sender);
        if (!_isAllowed) throw; 
    //check if flight conditions are good
    currentDestination = msg.sender;
oraclize_query("URL", APIURL);

}

function requestFlightOwner(address _to) ownerOnly {
    //no request if already a flight is already in progress
    if (currentDestination != 0x0) throw;
    //check if destination is Allowed
    _isAllowed = AllowedDroneCaller.isAllowed(_to);
        if (!_isAllowed) throw; 
    //check if flight conditions are good
    currentDestination = _to;
oraclize_query("URL", APIURL);
}

            /* Oracle callback */
    
function __callback(bytes32 myid, bool result) {
        if (msg.sender != oraclize_cbAddress()) throw;
        if (!result == false){ // or whatever the result type
           flightRequest(currentDestination, "refused");
           currentDestination = 0x0;
        }
        flightRequest(currentDestination, "accepted");
    }
    


    function resetState(string _uploadedTo) droneOnly {
flightLog(currentDestination, _uploadedTo);
currentDestination = 0x0;
}
    function resetStateOwner() ownerOnly {
flightLog(currentDestination, "state reseted by owner");
currentDestination = 0x0;
}
}
