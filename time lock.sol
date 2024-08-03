pragma solidity 0.8.19;

contract Lockfund{
 address public owner;
 constructor(){
	owner=payable(msg.sender);
 }
 mapping(address=>uint) public locked_funds;
 mapping(address=>uint) public locked_timestamps;
 
 uint public lock_duration=200;

 function lockfund(uint _values) public payable{
	require(msg.value>=_values);
	locked_funds[msg.sender]=_values;
	locked_timestamps[msg.sender]=block.timestamp;
 }
 function relesefund() public{
	require(block.timestamp>=locked_timestamps[msg.sender]+lock_duration,"please wait till the timwe lock get");
	payable(owner).transfer(locked_funds[msg.sender]);
	delete locked_funds[msg.sender];
	delete locked_timestamps[msg.sender]; 
 }
 function withdraw()public{
	require(msg.sender==owner,"only owner can withdraw");
	require(address(this).balance>0);
	payable(owner).transfer(address(this).balance);
}
}
