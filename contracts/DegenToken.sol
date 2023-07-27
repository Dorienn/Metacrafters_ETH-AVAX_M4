// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol"; 
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

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
            transferFrom(msg.sender, _receiver, _value);
        }

        function burnTokens(uint _value) external {
            require(balanceOf(msg.sender) >= _value, "You don't have enough DGN to burn!");
            burn(_value);
        }

        function redeemItem() external {
            uint256 redeemAmount = 100 * (10**decimals()); // Make tokens readable
            require(balanceOf(msg.sender) >= redeemAmount, "You do not have enough DGN tokens to redeem this item!");
            _burn(msg.sender, redeemAmount);
        }
}
