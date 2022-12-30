// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract SimpleStorage {
    uint256 public myNumber;
    string public name;

    function changeNumber(uint256 _num) public {
        myNumber = _num;
    }

    function changeName(string memory _newName) public {
        name = _newName;
    }

    function getName() public view returns(string memory) {
        return name;
    }
    
    function getNumber() public view returns(uint256) {
        return myNumber;
    }
}

// 0xd9145CCE52D386f254917e481eB44e9943F39138