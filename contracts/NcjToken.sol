pragma solidity ^0.5.2;

contract NcjToken {
	string public name = "NCJ Token";
	string public symbol = "NCJ";
	string public standard = "Ncj Token v1.0";
	uint256 public totalSupply;
	
	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);

	//approve
	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint256 _value
	);

	mapping(address => uint256) public balanceOf;
	mapping(address => mapping(address => uint256)) public allowance;

	constructor(uint256 _initialSupply) public {
		balanceOf[msg.sender] = _initialSupply;
		totalSupply = _initialSupply;
	}

	//Transfer 
	function transfer(address _to, uint256 _value) public returns(bool success){
		//Exception if account doen't have enough token
		require(balanceOf[msg.sender] >= _value);
		//Transfer the balance
		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;
		//Transfer event
		emit Transfer(msg.sender, _to, _value);
		//Reaturn a boolean
		return true;
	}

	//approve

	function approve(address _spender, uint256 _value) public returns (bool success){
		//allowance
		allowance[msg.sender][_spender] = _value;
		//Approve event
		emit Approval(msg.sender, _spender, _value);
		return true;
	}

	//transferFrom for deligated transfer
	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
		require (_value <= balanceOf[_from]);//Require _from has enough tokens
		require (_value <= allowance[_from][msg.sender]);//Require allowance is big enough
		balanceOf[_from] -= _value;//Change the balance
		balanceOf[_to] += _value;
		allowance[_from][msg.sender] -= _value; //Update the allowances
		emit Transfer(_from, _to, _value);//Transfer event
		return true; //return a boolean
	}
}