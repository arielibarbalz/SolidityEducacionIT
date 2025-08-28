// SPDX-License-Identifier: MIT
pragma solidity >0.8.0 <0.9.0;

/* Contrato 1 de entradas:

1) Una estructura Person que contenga Id, Nombre y Cantidad.

2) Un Mapeao desde el address del dueño de la entrada apuntando a la estructura Person en que la variable se llame cliente.

3) Si el cliente adquiere más de 2 entradas adquiere una entrada de lotería que estará en otro contrato (contrato 2).

4) Si el owner del contrato quiere puede comprar entradas asignandoselas a distintas personas (en batch) pero no participarán del sorteo.

5) Permitir cambiar la primera letra del nombre de tu persona por mayuscula si está en minuscula.

6) Si una función que se llame en este contrato no existe deberá llamar al contrato de loteria y buscar la misma función (ej: ver el ganador de la lotería)
*/

contract Ticket{
    // 1) Una estructura Person que contenga Id, Nombre y Cantidad.
    struct Person{
        uint256 id;
        string nombre;
        uint256 cantidad;
    }
    uint256 public constant price = 1*10**18;
    function getLotteryTicket() public {}
    uint256 public id;
  
    // 2) Un Mapeao desde el address del dueño de la entrada apuntando a la estructura Person en que la variable se llame cliente.
    address private owner;
    mapping(address => Person) public cliente;
      constructor() payable{
        owner = msg.sender;
    }

    // 3) Si el cliente adquiere más de 2 entradas adquiere una entrada de lotería que estará en otro contrato (contrato 2).
 
    function comprarEntradas(string calldata _name) external payable {
        require(price <= msg.value, "No alcanza");
        uint256 _cantidad = msg.value/price; // 19 / 10 = 1  | 9
        uint256 _devolucion = msg.value % price; 
        require(_devolucion < msg.value, "No te vamos a devolver mas");
        cliente[msg.sender].cantidad = _cantidad;
        cliente[msg.sender].nombre = _name;
        cliente[msg.sender].id = id;
        id++;
        if(_cantidad > 2){
            getLotteryTicket();
        }
        payable (msg.sender).transfer(_devolucion);
    }

    // 4) Si el owner del contrato quiere puede comprar entradas asignandoselas a distintas personas (en batch) pero no participarán del sorteo.
    function asignEntrada(address[] calldata _addr, Person[] calldata amigos) external  {
        require(msg.sender == owner, "usted no es el owner");
        uint256 _len = _addr.length;
        for(uint256 i; i < _len; i++){
            cliente[_addr[i]].cantidad = amigos[i].cantidad;
            cliente[_addr[i]].nombre = amigos[i].nombre;
            cliente[_addr[i]].id = amigos[i].id;
            id++;
        }
    }
    // 5) Permitir cambiar la primera letra del nombre de tu persona por mayuscula si está en minuscula.
    function cambioLetra() external  {
    //    require(cliente[msg.sender].id!=0);
        bytes memory _nombre = bytes(cliente[msg.sender].nombre);
        bytes1 _letra = _nombre[0];
        require(_letra > 0x60, "No es minuscula");
        _letra = bytes1(uint8(_letra) - 0x20);
        bytes(cliente[msg.sender].nombre)[0] = _letra;
     }

     fallback() external payable {   
    }

    receive() external payable { }

    function getLoteryTicket() internal pure returns(bool){
        return true;
    }

}