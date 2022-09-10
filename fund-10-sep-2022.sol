// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract A{
    address payable owner;

    // struct Funder {
    //     address funderAddress;
    //     uint256 amountPayed;
    //     uint256 amountWitdrawn;
    //     uint256 profit;
    // }
    
    // mapping (address => Funder) public Funders;
    mapping (address => uint) public user;
    mapping (address => uint) time;
    uint count=0;
    

    constructor(){
        owner = payable (msg.sender);
    }
    receive() external payable{}

    function deposit () public payable{
        
        require(msg.value >= 1 ether,"your amount is below 1 ether");
        user[msg.sender] += msg.value;
        time[msg.sender] += block.timestamp;
        // if (block.timestamp > start + 30 days) { }
        // if (block.timestamp % 15 == 0) {
        //     (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        //     require(sent, "Failed to send Ether");
        // }

        // Funders[msg.sender] = Funder({funderAddress : msg.sender,amountPayed : msg.value, amountWitdrawn : 0,profit : 0 });
    }
    function withdraw() public{
        require(user[msg.sender] > 0, "you have insufficent balance");
        if(block.timestamp - time[msg.sender] > 30){
            payable(msg.sender).transfer(user[msg.sender]+((user[msg.sender] *10) / 100));
        }
        else if(block.timestamp - time[msg.sender] > 40) {
            payable(msg.sender).transfer(user[msg.sender]+((user[msg.sender] *20) / 100));
        }
        else if(block.timestamp - time[msg.sender] > 50) {
            payable(msg.sender).transfer(user[msg.sender]+((user[msg.sender] *30) / 100));
        }
        else{
           payable(msg.sender).transfer(user[msg.sender]-((user[msg.sender] *30) / 100));
        }
        user[msg.sender] = 0;
        count ++;
    }
}
