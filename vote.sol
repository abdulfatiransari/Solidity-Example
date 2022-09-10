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
    mapping(address=>bool) isBlacklisted;

    modifier onlyadmin() {
        require(msg.sender == admin,"Your are not Admin");
        _;
    }

    Voter[] public voter;

    function vote (string memory _name, address _address) external {
        voter.push(Voter(_name, _address));
        
    }

    // function addUser(address _addressToWhitelist) public onlyadmin {
    //     whitelistedAddresses[_addressToWhitelist] = true;
    // }

    // function verifyUser(address _whitelistedAddress) public view returns(bool) {
    //     bool userIsWhitelisted = whitelistedAddresses[_whitelistedAddress];
    //     return userIsWhitelisted;
    // }


    function blackList(address _user) public onlyadmin {
        require(!isBlacklisted[_user], "user already blacklisted");
        isBlacklisted[_user] = true;
    }
    
    function whitelist(address _user) public onlyadmin {
        require(isBlacklisted[_user], "user already whitelisted");
        isBlacklisted[_user] = false;
    }

    function verify(address _user) public view returns(bool) {
                return isBlacklisted[_user];
        }
    
}
