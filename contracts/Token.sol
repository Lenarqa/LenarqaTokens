pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Token {
    string private name = "AsuCoin";
    string public symvbol = "AC";
    uint private _totalSupply = 1000000;
    address public owner;
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint256)) public _allowances;

    constructor() {
        balances[msg.sender] = _totalSupply;
        owner = msg.sender;//тот кто подключен к контракту.
    }

    // утвердить
    function approve(address spender, uint amount) external returns(bool) {
        // console.log(spender);
        // console.log(amount);
        require(owner != address(0), "Ownwer == address(0)");
        require(spender != address(0), "Spender == address(0)");
        _allowances[msg.sender][spender] = amount;//дает спивающему адресу доступ к amount токенов отдающего адреса
        
        // console.log(_allowances[msg.sender][spender]);
        //emit Approval(owner, spender, amount);//Вызывает евент из какой то библиотеки. Не обязателен в ERC20?
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint) {
        return _allowances[owner][spender];
    }

    function transfer(address to, uint amount) external {
        // console.log("Sender balance is %s tokens", balances[msg.sender]);
        // console.log("Trying to send %s AsuCoins to %s", amount, to);
        require(balances[msg.sender] >= amount, 'Not enough AsuCoun');
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function balanceOf(address account) external view returns(uint) {
        return balances[account];
    }

    function totalSupply() external view returns(uint) {
        return _totalSupply;
    } 

    function transferFrom(address sender, address recipient, uint256 amount) external returns(bool) {
        uint currentAllowance = _allowances[sender][msg.sender]; 
        require(currentAllowance >= amount, "Transfer amount exceeds allowance");
        unchecked { // эта функция зашищает от переполнения блока и отцицательных значений
            this._approve(sender, msg.sender, amount);
        }
        return true;
    } 

    function _approve(address owner, address spender, uint256 amount) external {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        //emit Approval(owner, spender, amount);
    }
}