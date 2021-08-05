const NcjToken = artifacts.require("./NcjToken.sol");
var NcjTokenSale = artifacts.require("./NcjTokenSale.sol");

module.exports = function (deployer) {
  deployer.deploy(NcjToken, 1000000).then(function(){
  	var tokenPrice = 1000000000000000; // in wei
  	return deployer.deploy(NcjTokenSale, NcjToken.address, tokenPrice);
  });
};
