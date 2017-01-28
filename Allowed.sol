pragma solidity ^0.4.7;
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