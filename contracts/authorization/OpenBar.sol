import "AbstractAuthorization.sol"

contract OpenBar is AbstractAuthorization {
    function isAllowed(address _member) returns (bool) {
      return true;
    }
}