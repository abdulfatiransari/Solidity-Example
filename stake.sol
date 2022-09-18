// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract B{
    struct StakerPerson {
        address stakerAddress;
        uint256 stakingAmount;
        uint256 amountWithdraw;
        uint256 profit;
        uint256 stakingDuration;
        // uint256 stackingWithdraw;
        // uint256 availableBalance;
    }
    
    mapping (address => StakerPerson) public Stakers;

    constructor() payable {
        
    }

    function stake() payable public {
        require (msg.value == 4 ether, "Value should be 4 Ether");
        if(Stakers[msg.sender].stakingAmount == 4 ether){
            revert("you need to withdraw before staking more");
        }
        Stakers[msg.sender] = StakerPerson({
            stakerAddress : msg.sender,
            stakingAmount : msg.value,
            profit : Stakers[msg.sender].profit,
            amountWithdraw : Stakers[msg.sender].amountWithdraw,
            stakingDuration : block.timestamp
        });
    }
    function withdraw() public {
        StakerPerson memory person = Stakers[msg.sender];
        require(person.stakingAmount == 4 ether,"Invalid Balance");
         uint256 currentTime = block.timestamp;
         uint256 duration = currentTime - person.stakingDuration;
         uint256 profit;
         if(duration > 60 && duration < 120 ){ // 1 minute
             profit = 1 ether;
         }
         else if (duration > 120 && duration <180){ // 2 minutes
             profit = 1.5 ether;
         }
         else if (duration > 180){ // 3 minutes
             profit = 2 ether;
         }
        
         (bool sent,) = payable(person.stakerAddress).call{value: person.stakingAmount + profit}("");
         if (!sent){
             revert ("tx failed");
         }
         Stakers[msg.sender] = StakerPerson({
             stakerAddress : msg.sender,
             stakingAmount : 0,
             profit : person.profit + profit,
             amountWithdraw : person.stakingAmount,
             stakingDuration : 0
         });
    }

}
