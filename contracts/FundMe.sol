// get funds from users
// withdraw funds
// set a minimum funding value in USD through Oracle


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    /*
    mapping(address => uint256) public addressToAmountFunded;

    address[] public funders;
    address public owner;

    constructor()  {
        owner = msg.sender;
    }
    */

    function fund() public payable {
        uint256 minimumUSD = 50 * 1e18;
        require(
            conversion(msg.value) >= minimumUSD,
            "You need to spend more ETH!"
        );
        /*addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);*/
    }

    function getPrice() public view returns(uint256) {
        //Required: ABI, Address
        //Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e

        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
         ( ,int256 answer, , , ) = priceFeed.latestRoundData();
         // price: 120186000000

         return uint256(answer * 1e10);
    }

    function conversion(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountToUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountToUsd;
    }

    function getVersion() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    // function withdraw() public payable {}
}