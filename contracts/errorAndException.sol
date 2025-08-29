// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PanicDemo {
    uint[] public numeros;
    
    // Eventos para mostrar los panics
    event PanicDetected(uint256 errorCode, string description);
    
    // ========== FUNCIONES QUE GENERAN PANICS DIRECTOS ==========
    
    function overflowPanic() public pure {
        uint256 x = type(uint256).max;
        x + 1; // Panic 0x11 - Arithmetic overflow
    }
    
    function arrayPanic() public view {
        numeros[100]; // Panic 0x32 - Array out of bounds
    }
    
    function popPanic() public {
        numeros.pop(); // Panic 0x31 - Pop empty array
    }
    
    function assertPanic() public pure {
        assert(1 == 2); // Panic 0x01 - Assert failed
    }
    
    function divisionPanic() public pure returns (uint256) {
        uint256 a = 10;
        uint256 b = 0;
        return a / b; // Panic 0x12 - Division by zero
    }
    
    // ========== FUNCIONES QUE CAPTURAN PANICS ==========
    
    function safeTestOverflow() public {
        try this.overflowPanic() {
            // No debería llegar aquí
        } catch Panic(uint errorCode) {
            emit PanicDetected(errorCode, "Arithmetic overflow detected");
        }
    }
    
    function safeTestArray() public {
        try this.arrayPanic() {
            // No debería llegar aquí
        } catch Panic(uint errorCode) {
            emit PanicDetected(errorCode, "Array access out of bounds detected");
        }
    }
    
    function safeTestPop() public {
        try this.popPanic() {
            // No debería llegar aquí
        } catch Panic(uint errorCode) {
            emit PanicDetected(errorCode, "Pop from empty array detected");
        }
    }
    
    function safeTestAssert() public {
        try this.assertPanic() {
            // No debería llegar aquí
        } catch Panic(uint errorCode) {
            emit PanicDetected(errorCode, "Assertion failed detected");
        }
    }
    
    function safeTestDivision() public {
        try this.divisionPanic() returns (uint256) {
            // No debería llegar aquí
        } catch Panic(uint errorCode) {
            emit PanicDetected(errorCode, "Division by zero detected");
        }
    }
    
    // ========== FUNCIONES AUXILIARES ==========
    
    function addNumero(uint256 _num) public {
        numeros.push(_num);
    }
    
    function getArrayLength() public view returns (uint256) {
        return numeros.length;
    }
    
    function getPanicDescription(uint256 code) public pure returns (string memory) {
        if (code == 0x01) return "Assertion failed";
        if (code == 0x11) return "Arithmetic overflow/underflow";
        if (code == 0x12) return "Division or modulo by zero";
        if (code == 0x31) return "Pop from empty array";
        if (code == 0x32) return "Array access out of bounds";
        return "Unknown panic code";
    }

    //Prueba rama
}