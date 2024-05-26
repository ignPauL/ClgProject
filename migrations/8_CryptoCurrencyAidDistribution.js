const CryptoCurrencyAidDistribution = artifacts.require("CryptoCurrencyAidDistribution");
module.exports= function (deployer){
    deployer.deploy(CryptoCurrencyAidDistribution);
}