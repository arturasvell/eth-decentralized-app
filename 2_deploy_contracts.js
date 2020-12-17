const MafiaManagementSystem = artifacts.require("MafiaManagementSystem")

module.exports = function(deployer) {
    deployer.deploy(MafiaManagementSystem)
}