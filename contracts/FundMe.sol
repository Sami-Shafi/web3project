// get funds from users
// withdraw funds
// set a minimum funding value in USD through Oracle


//SPDX-License-Identifier: MIT
pragma solidity 0.8.8;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    function fund() public payable  {
        // set minimum fund in USD
        require(msg.value >= 1e18, "Value is less than minimum amount.");
    }

    function getPrice() public {
        //Required: ABI, Address
        //Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
    }

    function getVersion() public view returns(uint256) {
        AggregatorV3Interface priceFeed =  AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate() public {}

    function withdraw() public payable {}
}