// get funds from users
// withdraw funds
// set a minimum funding value in USD through Oracle


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    mapping(address => uint256) public addressToAmountFunded;

    address[] public funders;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        uint256 minimumUSD = 50 * 1e18;
        require(
            msg.value.conversion() >= minimumUSD,
            "You need to spend more ETH!"
        );
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function withdraw() public onlyOwner {
        // require(msg.sender == owner, "Sender is not Owner!");

        // loop through the funders reset their fund count
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funderAddress = funders[funderIndex];
            addressToAmountFunded[funderAddress] = 0;
        }

        // reset funders
        funders = new address[](0);

        // handle the funds in real time
        // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // // send 
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Sending Failed!");

        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed!");
    }

    modifier onlyOwner {
        require(msg.sender == owner, "You are not the Owner!");
        _;
    }
}