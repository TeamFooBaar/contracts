pragma solidity ^0.4.7;
contract Withdraw {
   //safe withdraw?
   Withdraw ispayable;
function Withdraw() payable {
   selfdestruct(msg.sender);
}
}