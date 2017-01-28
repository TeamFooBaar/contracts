pragma solidity ^0.4.6;

contract Owned {
  /* The owner of the contract can add members and transfer ownership.
     initial value is the contract creator */
  address public owner = msg.sender;
  modifier ownerOnly() {
    if (msg.sender != owner) throw;
    _;
  }
