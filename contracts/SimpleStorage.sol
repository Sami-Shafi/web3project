// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract SimpleStorage {
    uint256 public myNumber;
    string public name;
    People public sami = People({personAge: 17, personName: "Sami"});

    struct People {
        uint256 personAge;
        string personName;
    }    

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