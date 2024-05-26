const DisasterReportingAndManagement = artifacts.require("DisasterReportingAndManagement");
module.exports= function (deployer){
    deployer.deploy(DisasterReportingAndManagement);
}