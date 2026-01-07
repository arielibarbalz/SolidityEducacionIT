// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "contracts/desafio3.sol";

contract LibreriaImplementada{

    function testLibreria(uint num) public pure returns (bool, string memory){

    return NumerosUtiles.esPar(num);
    }
}



