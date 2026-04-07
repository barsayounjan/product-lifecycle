// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProductLifecycle {

// Product stages
enum Stage { Design, Manufacturing, Sold }

// Product structure
struct Product {
uint id;
Stage stage;
address owner; // current owner
address buyer; // who bought it
}

// Store all products
mapping(uint => Product) public products;

// Total products created
uint public productCount;

// Total products sold
uint public soldCount;

// Create a new product
function createProduct() public {
productCount++;
products[productCount] = Product(
productCount,
Stage.Design,
msg.sender,
address(0)
);
}

// Move to Manufacturing stage
function startManufacturing(uint _id) public {
require(products[_id].stage == Stage.Design, "Must be in Design stage");

products[_id].stage = Stage.Manufacturing;
}

// Sell product to a buyer
function sellProduct(uint _id, address _buyer) public {
require(products[_id].stage == Stage.Manufacturing, "Must be in Manufacturing stage");

products[_id].stage = Stage.Sold;
products[_id].buyer = _buyer;
products[_id].owner = _buyer;

soldCount++; // increase sold count
}

// Get product details
function getProduct(uint _id) public view returns (
uint, Stage, address, address
) {
Product memory p = products[_id];
return (p.id, p.stage, p.owner, p.buyer);
}
}
