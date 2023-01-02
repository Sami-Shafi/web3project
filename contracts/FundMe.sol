// get funds from users
// withdraw funds
// set a minimum funding value in USD through Oracle


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./PriceConverter.sol";

// this error will trigger if the user is not authorized
error UnAuthorized();
error MinimumValueError();
error WithdrawFailed();

contract FundMe {
    using PriceConverter for uint256;

    mapping(address => uint256) public addressToAmountFunded;

    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] public funders;
    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        if (msg.value.conversion() < MINIMUM_USD) revert MinimumValueError();

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
        if (!callSuccess) revert WithdrawFailed();
    }

    modifier onlyOwner {
        // require(msg.sender == i_owner, "You are not the Owner!");
        if (msg.sender != i_owner) revert UnAuthorized();
        _;
    }
}