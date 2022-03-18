// SPDX-License-Identifier: AFL-1.1
//guscoins ICO

//Version of compiler
pragma solidity ^0.4.11;

contract guscoin_ico {

    // Introducing the maximum number of Guscoins available for sale
    uint public max_guscoins = 1000000;

    // Introducing the USD to Guscoins conversion rate
    uint public usd_to_guscoins = 1000;

    // Introducing the total number of Guscoins that have been bought by the investors
    uint public total_guscoins_bought = 0;

    // Mapping from the investor address to its equity in Guscoins and USD
    mapping(address => uint) equity_guscoins;
    mapping(address => uint) equity_usd;

    //Checking if an investor can buy Guscoins
    modifier can_buy_guscoins(uint usd_invested) {
        require ((usd_invested * usd_to_guscoins) + total_guscoins_bought <= max_guscoins);
        _;
    }

    // Getting the equity in Guscoins of an investor
    function equity_in_guscoins(address investor) external constant returns (uint) {
        return equity_guscoins[investor];
    }

    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }

    // Buying Guscoins
    function buy_guscoins(address investor, uint usd_invested) external
    can_buy_guscoins(usd_invested) {
        uint guscoins_bought = usd_invested * usd_to_guscoins;
        equity_guscoins[investor] += guscoins_bought;
        equity_usd[investor] = equity_guscoins[investor] / 1000;
        total_guscoins_bought += guscoins_bought;
    }

    // Selling Guscoins
    function sell_guscoins(address investor, uint guscoins_sold) external {
        equity_guscoins[investor] -= guscoins_sold;
        equity_usd[investor] = equity_guscoins[investor] / 1000;
        total_guscoins_bought -= guscoins_sold;
    }

}