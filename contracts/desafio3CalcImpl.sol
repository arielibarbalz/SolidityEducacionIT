// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "contracts/desafio3Calc.sol";


contract Calculadora{

    function sumarPorPolimorfismo(address direccionContrato, uint256 a, uint256 b) public pure returns (uint){

        ICalculadora calculadora = ICalculadora(direccionContrato);
        return calculadora.sumar(a, b);
    }

}
