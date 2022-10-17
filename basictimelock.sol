// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract basic_time_lock{
    mapping (address => uint) public balances;

    mapping (address => uint) public lockTime;

    address payable  sender = payable(msg.sender);

    function deposit() public payable {
        require(msg.value >= 1 ether,"your amount is below 1 ether");
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 30 seconds;
    }

    function withdraw() public {
        require(balances[msg.sender] >0,"Insufficient fund");
        require(block.timestamp > lockTime[msg.sender] ," Lock Time is not expired");

        sender.transfer(balances[msg.sender]);
    }
}
