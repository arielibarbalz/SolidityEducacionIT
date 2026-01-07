// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

library NumerosUtiles {

    function esPar(uint num) public pure returns (bool, string memory){
        
        if(num % 2 == 0){
            return (true, "Numero par");
        }
        else{
            return (false, "Numero impar");
        }
    }
    
}