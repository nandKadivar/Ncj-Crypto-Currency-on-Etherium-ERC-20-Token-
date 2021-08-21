pragma solidity ^0.5.2;
import "./NcjToken.sol";

contract NcjTokenSale{
	address payable admin;
	NcjToken public tokenContract;
	uint256 public tokenPrice;
	uint256 public tokensSold;

	event Sell(address _buyer, uint256 _amount);

	constructor(NcjToken _tokenContract, uint256 _tokenPrice) public {
		// Assign an admin
		admin = msg.sender;
		// Token Contract
		tokenContract = _tokenContract;
		// Token Price
		tokenPrice= _tokenPrice;
	}

	//multiply
	function multiply(uint256 x, uint256 y) internal pure returns (uint256 z){
		require(y == 0 || (z = x * y) / y == x);
	}

	//Buy Tokens
	function buyTokens(uint256 _numberOfTokens) public payable{
		//Require that value is equal to tokens
		require(msg.value == multiply(_numberOfTokens, tokenPrice));
		//Require that contract has enough tokens
		require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);
		//Require that a transfer is successfull
		require(tokenContract.transfer(msg.sender, _numberOfTokens));

		tokensSold += _numberOfTokens;
		
		//Trigger Sell Event 
		emit Sell(msg.sender, _numberOfTokens);
	}

	function endSale() public {
		//Require admin
		require(msg.sender == admin);
		// Transfer remaining ncj tokens to admin
		require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
		// Destroy contract
		selfdestruct(admin);
	}
}