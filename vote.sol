// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract voting{

    address public admin;
    constructor() {
        admin = (msg.sender);
    }

    struct Voter {
        string name;
        address _address;
    }

    // mapping(address => bool) whitelistedAddresses;
    mapping(address=>bool) user_status;

    modifier onlyadmin() {
        require(msg.sender == admin,"Your are not Admin");
        _;
    }

    Voter[] private voter;

    function vote (string memory _name, address _address) external {
        voter.push(Voter(_name, _address));
        
    }
    function getvoters() public view returns (Voter[] memory){
        require (msg.sender == admin, "You are not admin");
        return voter ;
    }

    function blackList(address _user) public onlyadmin {
        require(!user_status[_user], "user already blacklisted");
        user_status[_user] = false;
    }
    
    function whitelist(address _user) public onlyadmin {
        require(user_status[_user], "user already whitelisted");
        user_status[_user] = true;
    }

    function verify(address _user) public view returns(bool) {
                return user_status[_user];
        }
    
}
