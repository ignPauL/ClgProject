const AidPackageDistribution = artifacts.require("AidPackageDistribution");
module.exports= function (deployer){
    deployer.deploy(AidPackageDistribution);
}