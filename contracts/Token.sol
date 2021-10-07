pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Token {
    string public name = "LenarqaCoin";
    string public symbol = "LC";
    uint256 private _totalSupply = 1000000;
    uint8 public decimals = 18;

    address public owner;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    event Approval(address owner, address spender,uint256 amount);
    event Transfer(address owner, address spender,uint256 amount);

    constructor() {
        balances[msg.sender] = _totalSupply;
        owner = msg.sender;
    }

    function balanceOf(address account) external view returns(uint256) {
        return balances[account];
    }

    function totalSupply() external view returns(uint256) {
        return _totalSupply;
    } 

    function transfer(address recipient, uint256 amount) external { //recipient-получатель
        require(balances[msg.sender] >= amount, 'Error: Not enough AsuCoin');
        balances[msg.sender] -= amount;
        balances[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
    }

    function approve(address spender, uint256 amount) external returns(bool) {
        require(owner != address(0), "Error: Ownwer == address(0)");
        require(spender != address(0), "Error: Spender == address(0)");
        
        allowed[msg.sender][spender] = amount;
        emit Approval(owner, spender, amount);
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return allowed[owner][spender];
    }

    function transferFrom(address sender, address spender, uint256 amount) external returns(bool) {
        uint256 currentAllowance = allowed[sender][msg.sender]; 
        require(currentAllowance >= amount, "Transfer amount exceeds allowance");
        require(allowed[owner][spender] >= amount,'');
        allowed[owner][spender]-= amount;
        balances[msg.sender]-= amount;
        balances[spender]+= amount;
        return true;
    }
    
    function mint(address account, uint256 amount) external {
        balances[account]+= amount;
        _totalSupply+=amount;
    }

    function burn(address account, uint256 amount) external {
        require(balances[account]>=amount, "Error, we can,t burn more that you have in your balance");
        balances[account]-= amount;
        _totalSupply-=amount;
    }

    function increaseAllowance(address spender, uint256 addAmount) external returns (bool) {
        require(spender != address(0), "ERC20: approve to the zero address");
        allowed[msg.sender][spender] += addAmount;
        return true;
    }

    function decreaseAllowance(address spender, uint256 minusAmount) external returns (bool) {
        require(spender != address(0), "ERC20: approve to the zero address");
        allowed[msg.sender][spender] -= minusAmount;
        return true;
    }
}