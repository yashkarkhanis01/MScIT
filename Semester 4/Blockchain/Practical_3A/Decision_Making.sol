// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;contract
ifelsedemo
{
uint i=9;
function decision_making() public view returns(string memory)
{
if(i%2==0)
{
return "even";
}
else
{
return "Odd";
}
}
}