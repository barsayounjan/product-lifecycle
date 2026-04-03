// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProductLifecycle {

    enum Stage { Design, Manufacturing, Sold }

    Stage public currentStage;

    address public owner;

    constructor() {
        currentStage = Stage.Design;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function Manufacturing() public onlyOwner {
        require(currentStage == Stage.Design, "Must be in Design stage");
        currentStage = Stage.Manufacturing;
    }

    function Sold() public onlyOwner {
        require(currentStage == Stage.Manufacturing, "Must be in Manufacturing stage");
        currentStage = Stage.Sold;
    }

    function getStage() public view returns (Stage) {
        return currentStage;
    }
}