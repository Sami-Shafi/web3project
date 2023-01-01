//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns(uint256) {
        //Required: ABI, Address
        //Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e

        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
         ( ,int256 answer, , , ) = priceFeed.latestRoundData();
         // price: 120186000000

         return uint256(answer * 1e10);
    }

    function conversion(uint256 _ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountToUsd = (ethPrice * _ethAmount) / 1e18;
        return ethAmountToUsd;
    }

    function getVersion() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

}