// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Fund {

    modifier valueChecker() {
        require(msg.value > 1 ether,"Value cannot be less than 1 ether");
        _;
    }

    struct Funder {
        uint256 amount;
        address funderAddress;
        uint256 withdrawn;
    }

    mapping(address => Funder) public Funders;

    // Run's when there is no Data
    receive() external valueChecker payable {
         if(Funders[msg.sender].funderAddress == address(0)){
            Funders[msg.sender] = Funder({amount :  msg.value,funderAddress : msg.sender, withdrawn : 0});
        }
        else{
            Funder memory person = Funders[msg.sender];
            Funders[msg.sender] = Funder({amount :  person.amount + msg.value,funderAddress : msg.sender, withdrawn : person.withdrawn + 0});
        }
    }

    // Run's when there is Data
    fallback() external valueChecker payable { 
        if(Funders[msg.sender].funderAddress == address(0)){
            Funders[msg.sender] = Funder({amount :  msg.value,funderAddress : msg.sender, withdrawn : 0});
        }
        else{
            Funder memory person = Funders[msg.sender];
            Funders[msg.sender] = Funder({amount :  person.amount + msg.value,funderAddress : msg.sender, withdrawn : 0});
        }
    }

    function fund() public valueChecker payable {
         if(Funders[msg.sender].funderAddress == address(0)){
            Funders[msg.sender] = Funder({amount :  msg.value,funderAddress : msg.sender, withdrawn : 0});
        }
        else{
            Funder memory person = Funders[msg.sender];
            Funders[msg.sender] = Funder({amount :  person.amount + msg.value,funderAddress : msg.sender, withdrawn :person.withdrawn + 0});
        }
    }

    function getContractBalance() public view returns(uint256) {
        return address(this).balance;
    }

    function withdraw(address payable _funderAddress) public {
        require(_funderAddress == Funders[_funderAddress].funderAddress,"You are not a Funder");

        Funder memory funder = Funders[_funderAddress];

        (bool sent,) = _funderAddress.call{value : funder.amount}(""); 
        require(sent, "Not Send");


        Funders[_funderAddress].withdrawn += funder.amount;
        Funders[_funderAddress].amount = 0;
        
    }
}
