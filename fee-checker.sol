// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract A{
    address public admin;
    constructor(){
        admin = (msg.sender);
    }
     modifier onlyadmin() {
        require(msg.sender == admin,"Your are not Admin");
        _;
    }
    modifier fee_status(){
        require(msg.value == 1 ether, "Please pay the 1 Ether");
        _;
    }
    struct studentDetails{
        // string name;
        uint amount;
        address _address;
        bool _bool;
    }
    mapping(address => studentDetails) public student;

    function fee() public fee_status payable {
        if(student[msg.sender]._address == address(0)){
            student[msg.sender] = studentDetails({amount : msg.value, _address : msg.sender, _bool : true});
        }
        else {
            studentDetails memory person = student[msg.sender];
            student[msg.sender] = studentDetails({amount : person.amount + msg.value, _address : msg.sender, _bool : false}); 
        }
    }
    function checkStatus () public view returns (uint){
        require(msg.sender == admin, "you are not admin");
        return address(this).balance;
    }
}
