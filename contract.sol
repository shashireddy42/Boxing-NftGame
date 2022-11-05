// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Boxing is ERC721{
     constructor(address _Creator) ERC721("Boxing Player","PlayerNFT") {
      //assigning the msg.sender address to  Creator
      Creator=payable(_Creator);
    }

    struct Boxer{
         string name;
         uint id;
         uint points;
         uint grade;
    }
    
     address payable public Creator;
     //stores the player info by player id , playerid=>Player
    mapping(uint=>Boxer) public Players;
    // stores the price of playerid, playerid => price 
    mapping (uint=>uint) public PlayersPrice; 
    uint internal _id=1001;

     modifier onlyOwnerOf() {
        require(Creator==msg.sender, "Must be owner of Boxer to Play");
        _;
    }
    //Creating a new player by creator
    function NewPlayer(string memory _name,uint _points) public {
         require(msg.sender == Creator, "Only game owner can create new Players");
         Players[_id]=Boxer(_name,_id,_points,1000);
        _safeMint(msg.sender,_id); 
         _id++;
    }
    //Game logic
     function Game(uint _attackingBoxer, uint _defendingBoxer) public onlyOwnerOf{
        Boxer storage attacker = Players[_attackingBoxer];
        Boxer storage defender = Players[_defendingBoxer];
        
        if (attacker.points > defender.points) {
            require(attacker.grade>0,"Attacker died");
        require(defender.grade>0,"Defender died");
            attacker.grade += 100;
            defender.grade -= 50;
        }
        else if(attacker.points<defender.points){
            require(attacker.grade>0,"Attacker died");
        require(defender.grade>0,"Defender died");
            attacker.grade -= 50;
            defender.grade += 100;
        }
        else if(attacker.points==defender.points){
            require(attacker.grade>0,"Attacker died");
        require(defender.grade>0,"Defender died");
            attacker.grade+=50;
            defender.grade+=50;
        }
    }
    //Users to set the price of Nft 
    function allowBuy(uint Bxrid,uint _price) public  {
    _price=_price*10**18;
    require(msg.sender == ownerOf(Bxrid), "You are not holding the Boxer card");
       require(_price>= 1 ether,"Price must be greater than 1 ether");
        PlayersPrice[Bxrid] = _price;
    }
    //To buy the nft by using ether
      function buyPlayerCard(uint Bxrid) payable public {
        address seller = ownerOf(Bxrid);
        _transfer(seller, msg.sender, Bxrid);
         (bool sent,)=payable(seller).call{value:msg.value}(""); 
        require(sent,"Failed to send ether");
      }

}// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Boxing is ERC721{
     constructor(address _Creator) ERC721("Boxing Player","PlayerNFT") {
      //assigning the msg.sender address to  Creator
      Creator=payable(_Creator);
    }

    struct Boxer{
         string name;
         uint id;
         uint points;
         uint grade;
    }
    
     address payable public Creator;
     //stores the player info by player id , playerid=>Player
    mapping(uint=>Boxer) public Players;
    // stores the price of playerid, playerid => price 
    mapping (uint=>uint) public PlayersPrice; 
    uint internal _id=1001;

     modifier onlyOwnerOf() {
        require(Creator==msg.sender, "Must be owner of Boxer to Play");
        _;
    }
    //Creating a new player by creator
    function NewPlayer(string memory _name,uint _points) public {
         require(msg.sender == Creator, "Only game owner can create new Players");
         Players[_id]=Boxer(_name,_id,_points,1000);
        _safeMint(msg.sender,_id); 
         _id++;
    }
    //Game logic
     function Game(uint _attackingBoxer, uint _defendingBoxer) public onlyOwnerOf{
        Boxer storage attacker = Players[_attackingBoxer];
        Boxer storage defender = Players[_defendingBoxer];
        
        if (attacker.points > defender.points) {
            require(attacker.grade>0,"Attacker died");
        require(defender.grade>0,"Defender died");
            attacker.grade += 100;
            defender.grade -= 50;
        }
        else if(attacker.points<defender.points){
            require(attacker.grade>0,"Attacker died");
        require(defender.grade>0,"Defender died");
            attacker.grade -= 50;
            defender.grade += 100;
        }
        else if(attacker.points==defender.points){
            require(attacker.grade>0,"Attacker died");
        require(defender.grade>0,"Defender died");
            attacker.grade+=50;
            defender.grade+=50;
        }
    }
    //Users to set the price of Nft 
    function allowBuy(uint Bxrid,uint _price) public  {
    _price=_price*10**18;
    require(msg.sender == ownerOf(Bxrid), "You are not holding the Boxer card");
       require(_price>= 1 ether,"Price must be greater than 1 ether");
        PlayersPrice[Bxrid] = _price;
    }
    //To buy the nft by using ether
      function buyPlayerCard(uint Bxrid) payable public {
        address seller = ownerOf(Bxrid);
        _transfer(seller, msg.sender, Bxrid);
         (bool sent,)=payable(seller).call{value:msg.value}(""); 
        require(sent,"Failed to send ether");
      }

}
