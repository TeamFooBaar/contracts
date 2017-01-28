module.exports = function(deployer) {
  deployer.deploy(OpenBar).then(() => {
  	console.log(OpenBar.address)
  	return deployer.deploy(DroneNoOraclize, "0x2170e0bb64a50a6927d6ad29099b284a0453980d", OpenBar.address, "")
  })
};
