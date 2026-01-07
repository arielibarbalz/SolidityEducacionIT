// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "contracts/desafio3Calc.sol";

contract Calculadora is ICalculadora{

    function sumar(uint256 a, uint256 b) external pure override returns(uint256){
        return a + b;
    }

}