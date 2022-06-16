//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Ambiswap is ERC20 {
    address public NiznetTokenAddress;
    uint public ethReserve;

    constructor(address _NiznetTokenAddress) ERC20("Ambiswap LP Token", "ALP") payable {
      NiznetTokenAddress = _NiznetTokenAddress;
    }

    function calculateOutputAmount(uint inputAmount, uint inputReserve, uint outputReserve) private pure returns (uint) {
      uint outputAmount = (outputReserve * inputAmount) / (inputReserve + inputAmount);
      return outputAmount;
    }

    function _getReserve() external returns(uint) {
      return ERC20(NiznetTokenAddress).balanceOf(address(this));
    }

    function addLiquidity(uint _amount) public payable returns(uint) {
      require(_amount > 0, "Amount must be larger than zero.");

      if (ethReserve == 0) {
        // Set the initial liquidity of pool, which is what the user pays
        ethReserve = msg.value;
        // Transfer Niznet token to contract
        ERC20(NiznetTokenAddress).transferFrom(msg.sender, address(this), _amount);

        // Mint LP tokens in a 1 to 1 relationship with Eth, for now
        _mint(msg.sender, ethReserve);

        return ethReserve;
      }
      // getReserve function invoked, gets number of NizNet tokens assigned to Exchange
      uint tokenReserve = _getReserve();
      // Proportion of LP tokens to be assigned to user providing liquidity
      uint proportionOfTokens = (msg.value * tokenReserve) / ethReserve;

      _mint(msg.sender, proportionOfTokens);


    }

    function removeLiquidity(uint _amount) external {
      require(balanceOf(msg.sender) > 0, "You are not a Liquidity Provider for this pool");

      tokensToRecieve = (ethReserve * balanceOf(msg.sender));
      ethToRecieve =
    }

    function swapEthForToken() external {

    }

    function swapTokenForEth() external {

    }
}
