pragma solidity 0.8.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SocialMoney is ERC20 {

    /**
     * @dev Constructor on SocialMoney
     * @param _name string Name parameter of Token
     * @param _symbol string Symbol parameter of Token
     * @param _decimals uint8 Decimals parameter of Token
     * @param _proportions uint256[3] Parameter that dictates how totalSupply will be divvied up,
                            _proportions[0] = Vesting Beneficiary Initial Supply
                            _proportions[1] = Turing Supply
                            _proportions[2] = Vesting Beneficiary Vesting Supply
     * @param _vestingBeneficiary address Address of the Vesting Beneficiary
     * @param _platformWallet Address of Turing platform wallet
     * @param _tokenVestingInstance address Address of Token Vesting contract
     */
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256[3] memory _proportions,
        address _vestingBeneficiary,
        address _platformWallet,
        address _tokenVestingInstance
    )
    public
    {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;

        uint256 totalProportions = _proportions[0].add(_proportions[1]).add(_proportions[2]);

        _mint(_vestingBeneficiary, _proportions[0]);
        _mint(_platformWallet, _proportions[1]);
        _mint(_tokenVestingInstance, _proportions[2]);

        //Sanity check that the totalSupply is exactly where we want it to be
        assert(totalProportions == totalSupply());
    }
}