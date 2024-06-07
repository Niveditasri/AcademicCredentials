##SimpleContract
A simple smart contract to demonstrate the use of require(), assert(), and revert() statements in Solidity.

##Description
This project showcases a basic smart contract implemented in Solidity. The contract allows users to deposit and withdraw funds while ensuring proper error handling using require(), assert(), and revert() statements. The goal is to provide a clear understanding of these error-handling mechanisms within the context of a smart contract.

##Getting Started
Installing
Download the Project:

Clone the repository from GitHub.
sh
Copy code
git clone https://github.com/yourusername/SimpleContract.git
Install Dependencies:

Make sure you have Node.js and npm installed.
Install Truffle if not already installed:
sh
Copy code
npm install -g truffle
Executing Program
Compile the Smart Contract:

Navigate to the project directory.
sh
Copy code
cd SimpleContract
Compile the contract using Truffle:
sh
Copy code
truffle compile
Deploy the Smart Contract:

Deploy the contract to a local development blockchain.
sh
Copy code
truffle migrate
Interact with the Smart Contract:

Use Truffle console to interact with the contract:
sh
Copy code
truffle console
In the console, you can interact with the contract. For example:
sh
Copy code
let instance = await SimpleContract.deployed()
await instance.deposit(100)
await instance.withdraw(50)
await instance.forceRevert()
Help
If you encounter common issues or errors while interacting with the contract, here are a few tips:

Ensure you have sufficient Ether in your account when calling functions that change the state.
Check for proper installation of dependencies and versions of Node.js and npm.
Verify the smart contract deployment on the correct network (development, testnet, or mainnet).
For detailed Truffle commands and options:

sh
Copy code
truffle help
##Authors
Contributors' names and contact info:

Metacrafters team
-Nivedita

##License
This project is licensed under the MIT License.
