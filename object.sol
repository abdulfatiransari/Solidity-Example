// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract task2{
    //global variable function
    uint sv = 10;

    //state variable function\
    //get function
    function state_variable () public view returns (uint){
        return sv;
    }
    //local variable function
    //set function
    function local_variable () public {
        sv = 20;
    }
}
