// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleContract {
    uint256 public balance;

    // Function to deposit an amount
    function deposit(uint256 amount) public {
        // Using require to ensure the deposit amount is greater than zero
        require(amount > 0, "Deposit amount must be greater than zero.");
        balance += amount;
    }

    // Function to withdraw an amount
    function withdraw(uint256 amount) public {
        // Using require to ensure there is enough balance to withdraw
        require(balance >= amount, "Insufficient balance.");
        
        // Adjust the balance and assert to check for underflow
        balance -= amount;
        assert(balance >= 0); // This should always hold true
    }

    // Function to always revert
    function forceRevert() public {
        // Using revert to deliberately revert the transaction
        revert("This function always reverts.");
    }
}
