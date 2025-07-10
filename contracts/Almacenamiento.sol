// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

//Este es el desafio 1 del Alumni modulo 1

contract Almacenamiento {
    uint256 dato;
    function almacenar(uint256 num) public{
        dato = num;
    }
    function retornar()public view returns (uint256){
        return dato;
    }
    
}