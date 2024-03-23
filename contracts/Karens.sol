// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//No flavors of uint will be used. The cost of using different uints is minimal for this project.

contract Karens is Ownable, ERC20Capped {

    /*
    //OWNER BLOCK
    //Scan website and hardhat compiles the same contract differently. One of them requires
    //the initiation of Ownable contract in constructor area, and hardhat gives error if I do so.
    //To overcome this issue and not lose more time I am creating my own owner logic down.
    address public owner;
    modifier onlyOwner() {
        if(msg.sender != owner) {
            revert("You are not owner");
        }
        _;
    }
    function transferOwnership(address _newOwner) external onlyOwner{
        owner = _newOwner;
    }
    */


    //creating token based on lazy minting capped model
    //cap will be set to 100.000.000.000 (100 billion)
    //1% project team, The rest is for public.
    constructor(uint _cap) ERC20("Karens", "KRN") ERC20Capped(_cap*(10**18)) {
        
    }

    //*****FREE TOKENS*****
    bool public freeMinting = true;
    function toggleFree() external onlyOwner {
        freeMinting = !freeMinting;
    }

    uint public cooldown = 1;//random value to initiate cooldown.
    function mintPublic() external {
        require(freeMinting == true, "Free minting disabled by Owner");
        require(block.timestamp > cooldown + 20 minutes, "wait 20 mins to mint again");
        cooldown = block.timestamp;
        _mint(msg.sender, 50*(10**18));
    }
 

    //*******SIDE FUNCTIONS*******
    //burn token function, open to anybody, decimals handled for easy frontend integration
    //After successful launch of the project, a burn website will be created to burn tokens and 
    //add more value to the remaining tokens.
    function burnToken(uint _amount) external {
        require(_amount > 0, "Enter an amount to burn");
        require(uint(balanceOf(msg.sender)) > 0, "You dont have tokens to burn");
        _burn(msg.sender, _amount*(10**18));
    }

    function getTotalSupply() external view returns(uint) {
        return totalSupply() / (10**18);
    }

    function getYourTokenBalance() external view returns(uint) {
        return balanceOf(msg.sender) / (10**18);
    } 

    function getContractTokenBalance() external view returns(uint) {
        return balanceOf(address(this)) / (10**18);
    }

}

