// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./object.sol";

contract task1 is task2{
    string _str = "Hello Solidity";
    function str () public view returns (string memory){
        return _str;
    }
}
