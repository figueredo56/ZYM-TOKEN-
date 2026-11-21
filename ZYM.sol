// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ZYM {
    string public constant name = "ZYM";
        string public constant symbol = "ZYM";
            uint8 public constant decimals = 18;
                uint256 public totalSupply;

                    address public owner;

                        mapping(address => uint256) public balanceOf;
                            mapping(address => mapping(address => uint256)) public allowance;

                                event Transfer(address indexed from, address indexed to, uint256 value);
                                    event Approval(address indexed owner, address indexed spender, uint256 value);
                                        event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

                                            modifier onlyOwner() {
                                                    require(msg.sender == owner, "Caller is not the owner");
                                                            _;
                                                                }

                                                                    constructor() {
                                                                            owner = msg.sender;
                                                                                    emit OwnershipTransferred(address(0), msg.sender);

                                                                                            uint256 initialSupply = 1_000_000 * 10**18;
                                                                                                    totalSupply = initialSupply;
                                                                                                            balanceOf[msg.sender] = initialSupply;
                                                                                                                    emit Transfer(address(0), msg.sender, initialSupply);
                                                                                                                        }

                                                                                                                            function transfer(address to, uint256 amount) external returns (bool) {
                                                                                                                                    _transfer(msg.sender, to, amount);
                                                                                                                                            return true;
                                                                                                                                                }

                                                                                                                                                    function approve(address spender, uint256 amount) external returns (bool) {
                                                                                                                                                            require(spender != address(0), "Approve to zero address");
                                                                                                                                                                    allowance[msg.sender][spender] = amount;
                                                                                                                                                                            emit Approval(msg.sender, spender, amount);
                                                                                                                                                                                    return true;
                                                                                                                                                                                        }

                                                                                                                                                                                            function transferFrom(address from, address to, uint256 amount) external returns (bool) {
                                                                                                                                                                                                    uint256 currentAllowance = allowance[from][msg.sender];
                                                                                                                                                                                                            if (currentAllowance != type(uint256).max) {
                                                                                                                                                                                                                        require(currentAllowance >= amount, "Insufficient allowance");
                                                                                                                                                                                                                                    allowance[from][msg.sender] = currentAllowance - amount;
                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                    _transfer(from, to, amount);
                                                                                                                                                                                                                                                            return true;
                                                                                                                                                                                                                                                                }

                                                                                                                                                                                                                                                                    function burn(uint256 amount) external {
                                                                                                                                                                                                                                                                            require(balanceOf[msg.sender] >= amount, "Insufficient balance to burn");
                                                                                                                                                                                                                                                                                    balanceOf[msg.sender] -= amount;
                                                                                                                                                                                                                                                                                            totalSupply -= amount;
                                                                                                                                                                                                                                                                                                    emit Transfer(msg.sender, address(0), amount);
                                                                                                                                                                                                                                                                                                        }

                                                                                                                                                                                                                                                                                                            function renounceOwnership() external onlyOwner {
                                                                                                                                                                                                                                                                                                                    emit OwnershipTransferred(owner, address(0));
                                                                                                                                                                                                                                                                                                                            owner = address(0);
                                                                                                                                                                                                                                                                                                                                }

                                                                                                                                                                                                                                                                                                                                    function _transfer(address from, address to, uint256 amount) internal {
                                                                                                                                                                                                                                                                                                                                            require(from != address(0), "Transfer from zero address");
                                                                                                                                                                                                                                                                                                                                                    require(to != address(0), "Transfer to zero address");
                                                                                                                                                                                                                                                                                                                                                            require(balanceOf[from] >= amount, "Insufficient balance");

                                                                                                                                                                                                                                                                                                                                                                    balanceOf[from] -= amount;
                                                                                                                                                                                                                                                                                                                                                                            balanceOf[to] += amount;
                                                                                                                                                                                                                                                                                                                                                                                    emit Transfer(from, to, amount);
                                                                                                                                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                                                                                                                                        }
