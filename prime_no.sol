// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;
contract A{
    function prime_no (uint n) public pure returns (string memory){
    for(uint i = 2; i < n; i++){
        if(n % 2 == 0){
            return "is not a Prime Number";
        }
    }
    return "is a Prime Number";
    }
}