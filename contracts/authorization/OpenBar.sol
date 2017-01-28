pragma solidity ^0.4.6;
import "./AbstractAuthorization.sol";

contract OpenBar is AbstractAuthorization {
    function isAllowed(address _member) constant returns (bool) {
      return true;
    }
}