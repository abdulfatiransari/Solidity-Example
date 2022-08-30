// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract B{
    function palindrome (uint n) public pure returns (uint){
        uint reversed = 0;
        uint reminder;
        uint _n = n;
        while (n != 0){
            reminder = n % 10;
            reversed = (reversed * 10) + reminder;
            n /= 10;
        }
        if (_n == reversed)
        return 1;   //is palindrome
        else
        return 0;   //is not palindrome
    }
}