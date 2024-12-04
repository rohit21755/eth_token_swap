// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}
contract TokenSwap {
    IERC20 public token1;
    address public owner1;
    IERC20 public token2;
    address public owner2;

    constructor( address _token1, address _owner1, address _token2, address _owner2) {
        token1 = IERC20(_token1);
        owner1 = _owner1;
        owner2 = _owner2;
        token2 = IERC20(_token2);


    }




    function swap(uint amount1, uint amount2) public {
        require(msg.sender == owner1 || msg.sender == owner2);

        require(token1.allowance(owner1, address(this)) >= amount1, "Token 1 allowance too low");
        require(token2.allowance(owner2, address(this)) >= amount2, "Token 2 allowance  too low");
        _safeTransfer(token1,owner1 , owner2, amount1);
        _safeTransfer(token2,owner2 , owner1, amount2);
    }

    function _safeTransfer(
        IERC20 token,
        address sender,
        address recipient,
        uint amount
    ) private {
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "Token trasfered failed");
    }
}
