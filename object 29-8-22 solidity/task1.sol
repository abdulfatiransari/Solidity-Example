// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract A{
    function power (uint x, uint y) public pure returns (uint){
        if (y == 0)
        return 1;
        else if (y % 2 == 0)
        return power (x, y / 2) * power (x, y /2);
        else
        return x*power (x, y / 2) * power (x, y / 2);
    }
}