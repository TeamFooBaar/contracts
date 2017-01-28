module.exports = function(deployer) {
  deployer.deploy(OpenBar).then(() => {
  	return deployer.deploy(DroneNoOraclize, "0x7354fcc6546002692219181ebd6d78a1882ffaba", OpenBar.address, "")
  })
};
