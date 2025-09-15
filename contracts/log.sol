// SPDX-License-Identifier: MIT
pragma solidity >0.7.0 <0.9.0;
// Clase 5

contract Logs {

    uint256 id = 0;
    address payable owner;

    event Deposit(
        address indexed _from,
        uint256 indexed _id,
        uint _value
    );

    function depositWei() external payable {
        uint256 _id = id;
        _id++;
        emit Deposit(msg.sender, _id, msg.value);
        id = _id;
    }

    modifier onlyOwner(address _owner) {
        require(owner == _owner, "Not the owner");
        _;
    }
    function extraerWei() external onlyOwner(msg.sender){
        payable(msg.sender).transfer(address(this).balance);
    }
    // Comentario para poder subir rama Kali
}