pragma solidity >=0.4.22 <0.8.0;

contract MafiaService{
    string public name;
    
    uint public hitmanTax;
    uint public contractCount=0;
    uint public hitmenCount=0;
    mapping(uint => Hitman) hitmen;
    mapping(uint=>Contract) contracts;
    struct Hitman{
        uint id;
        address payable hitmanAddress;
        string codename;
        string description;
        uint price;
        bool isAvailable;
    }
    struct Contract{
        uint id;
        address payable contractor;
        string method;
        string description;
        uint reward;
        bool isCompleted;
    }
    
    event HitmanAdded(address payable hitmanAddress,string codename,string description,uint price,bool isAvailable);
    event ContractAdded(uint id, address payable contractor,string method, string description, uint reward, bool isCompleted);
    event ContractCompleted(uint id, address payable hitmanAddress);
    event ContractPaid(uint _contractId, address payable hitmanWallet, address payable contractorWallet);
    constructor() public{
        name="The Continental";
        hitmanTax=10;
        contractCount=0;
    }
    function AddHitman(address payable _hitmanAddress, string memory _codename, string memory _description, uint _price) public
    {
        require(bytes(_codename).length>0);
        require(_price>0);
        hitmenCount++;
        hitmen[hitmenCount-1]=Hitman(hitmenCount-1,_hitmanAddress,_codename,_description,_price,true);
        emit HitmanAdded(_hitmanAddress,_codename,_description,_price,true);
    }
    function CreateContract(address payable _contractor, string memory _method, string memory _description, uint _reward) public{
        require(bytes(_method).length>0);
        require(bytes(_description).length>0);
        require(_reward>0);
        contracts[contractCount]=Contract(contractCount,_contractor,_method,_description,_reward,false);
        contractCount++;
        emit ContractAdded(contractCount-1,_contractor,_method,_description,_reward,false);
    }
    function CompleteContract(uint _contractId, uint _hitmanId) public payable
    {
        Contract memory contractToComplete=contracts[_contractId];
        Hitman memory hitmanComplete=hitmen[_hitmanId];
        require(contractToComplete.isCompleted==false);
        contractToComplete.isCompleted=true;
        emit ContractCompleted(_hitmanId,hitmanComplete.hitmanAddress);
    }
    function PayContractReward(uint _contractId, uint _hitmanId, address payable _hitmanWallet, address payable _contractorWallet) public
    {
        require(_contractorWallet.balance>hitmen[_hitmanId].price+contracts[_contractId].reward);
        _hitmanWallet.transfer(hitmen[_hitmanId].price+contracts[_contractId].reward);
    }
}