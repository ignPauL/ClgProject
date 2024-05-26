const SecureDataStorage = artifacts.require("SecureDataStorage");
module.exports= function (deployer){
    deployer.deploy(SecureDataStorage);
}