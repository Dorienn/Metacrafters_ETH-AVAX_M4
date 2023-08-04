// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol"; 
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {

    constructor() ERC20("Degen", "DGN") {}

        function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
        }

        function getBalance() external view returns (uint256) {
            return balanceOf(msg.sender);
        }

        function transferTokens(address _receiver, uint256 _value) external {
            require(balanceOf(msg.sender) >= _value, "You do not have enough DGN tokens!");
            approve(msg.sender, _value);
            transferFrom(msg.sender, _receiver, _value);
        }

        function burnTokens(uint _value) external {
            require(balanceOf(msg.sender) >= _value, "You don't have enough DGN to burn!");
            burn(_value);
        }

        function redeemItem(string memory item) external {
            uint256 redeemAmount;

            if (compareStrings(item, "Shirt")) {
                redeemAmount = 200;
                require(balanceOf(msg.sender) >= redeemAmount, "You do not have enough DGN tokens to redeem this item!");
                console.log("Thank you for redeeming a shirt! Enjoy!");
            } else if (compareStrings(item, "Badge")) {
                redeemAmount = 100; 
                require(balanceOf(msg.sender) >= redeemAmount, "You do not have enough DGN tokens to redeem this item!");
                console.log("Thank you for redeeming a badge! Enjoy!");
            } else if (compareStrings(item, "Mug")) {
                redeemAmount = 50;
                require(balanceOf(msg.sender) >= redeemAmount, "You do not have enough DGN tokens to redeem this item!");
                console.log("Thank you for redeeming a mug! Enjoy!");
            } else {
                revert("Invalid item type!");
            }

            _burn(msg.sender, redeemAmount);            
        }

        // Compare two strings
        function compareStrings(string memory a, string memory b) internal pure returns (bool) {
            return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
        }
}
