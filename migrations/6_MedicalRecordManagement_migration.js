const MedicalRecordManagement = artifacts.require("MedicalRecordManagement");
module.exports= function (deployer){
    deployer.deploy(MedicalRecordManagement);
}