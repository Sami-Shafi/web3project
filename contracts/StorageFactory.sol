// SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function storeFunc(uint256 _itemIndex, uint256 _itemParamValue) public {
        //required: address, ABI
        simpleStorageArray[_itemIndex].store(_itemParamValue);
    }

    function retrieveFunc(uint256 _itemIndex) public view returns(uint256) {
        return simpleStorageArray[_itemIndex].retrieve();
    }

}