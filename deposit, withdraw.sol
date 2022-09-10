// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract A{
    address payable owner;
    mapping (address => uint) public user;
    uint count=0;
    constructor(){
        owner = payable (msg.sender);
    }
    function deposit () public payable{
        require(msg.value >= 1 ether,"your amount is below 1 ether");
        user[msg.sender] += msg.value;
    }
    function withdraw() public{
        require(user[msg.sender] > 0, "you have insufficent balance");
        if(count == 0){
            payable(msg.sender).transfer(user[msg.sender]-((user[msg.sender] / 100) * 10));
        }
        else if(count == 1) {
            payable(msg.sender).transfer(user[msg.sender]-((user[msg.sender] / 100) * 20));
        }
        else if(count == 2) {
            payable(msg.sender).transfer(user[msg.sender]-((user[msg.sender] / 100) * 30));
        }
        else{
            payable(msg.sender).transfer(user[msg.sender]);
        }
    }
}
