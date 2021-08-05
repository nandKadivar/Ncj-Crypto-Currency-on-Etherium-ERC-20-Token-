pragma solidity ^0.5.2;
import "./NcjToken.sol";

contract NcjTokenSale{
	address admin;
	NcjToken public tokenContract;
	uint256 public tokenPrice;

	constructor(NcjToken _tokenContract, uint256 _tokenPrice) public {
		// Assign an admin
		admin = msg.sender;
		// Token Contract
		tokenContract = _tokenContract;
		// Token Price
		tokenPrice= _tokenPrice;
	}
}