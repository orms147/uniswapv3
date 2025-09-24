// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import 'lib/v3-core/contracts/interfaces/IUniswapV3Pool.sol';
import 'lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol';
import 'lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol';

import '../interfaces/INonfungiblePositionManager.sol';
import '../interfaces/IPeripheryImmutableState.sol';
import '../interfaces/IPoolInitializer.sol';
import '../interfaces/IERC721Permit.sol';
import '../interfaces/IPeripheryPayments.sol';

/// @title NFT positions
/// @notice Wraps Uniswap V3 positions in the ERC721 non-fungible token interface
contract NonfungiblePositionManager is 
    INonfungiblePositionManager,
    ERC721
{
    /// @inheritdoc IPeripheryImmutableState
    address public immutable override factory;
    /// @inheritdoc IPeripheryImmutableState
    address public immutable override WETH9;

    constructor(
        address _factory,
        address _WETH9
    ) ERC721("Uniswap V3 Positions NFT-V1", "UNI-V3-POS") {
        factory = _factory;
        WETH9 = _WETH9;
    }

    /// @inheritdoc INonfungiblePositionManager
    function positions(uint256 tokenId)
        external
        view
        override
        returns (
            uint96 nonce,
            address operator,
            address token0,
            address token1,
            uint24 fee,
            int24 tickLower,
            int24 tickUpper,
            uint128 liquidity,
            uint256 feeGrowthInside0LastX128,
            uint256 feeGrowthInside1LastX128,
            uint128 tokensOwed0,
            uint128 tokensOwed1
        )
    {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc INonfungiblePositionManager
    function mint(MintParams calldata params)
        external
        payable
        override
        returns (
            uint256 tokenId,
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        )
    {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc INonfungiblePositionManager
    function increaseLiquidity(IncreaseLiquidityParams calldata params)
        external
        payable
        override
        returns (
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        )
    {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc INonfungiblePositionManager
    function decreaseLiquidity(DecreaseLiquidityParams calldata params)
        external
        payable
        override
        returns (uint256 amount0, uint256 amount1)
    {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc INonfungiblePositionManager
    function collect(CollectParams calldata params)
        external
        payable
        override
        returns (uint256 amount0, uint256 amount1)
    {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc INonfungiblePositionManager
    function burn(uint256 tokenId) external payable override {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc IPoolInitializer
    function createAndInitializePoolIfNecessary(
        address token0,
        address token1,
        uint24 fee,
        uint160 sqrtPriceX96
    ) external payable override returns (address pool) {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc IERC721Permit
    function PERMIT_TYPEHASH() external pure override returns (bytes32) {
        return keccak256("Permit(address spender,uint256 tokenId,uint256 nonce,uint256 deadline)");
    }

    /// @inheritdoc IERC721Permit
    function DOMAIN_SEPARATOR() external view override returns (bytes32) {
        return keccak256(abi.encode(
            keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
            keccak256(bytes("Uniswap V3 Positions NFT-V1")),
            keccak256(bytes("1")),
            block.chainid,
            address(this)
        ));
    }

    /// @inheritdoc IERC721Permit
    function permit(
        address spender,
        uint256 tokenId,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable override {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc IPeripheryPayments
    function unwrapWETH9(uint256 amountMinimum, address recipient) external payable override {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc IPeripheryPayments
    function refundETH() external payable override {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc IPeripheryPayments
    function sweepToken(
        address token,
        uint256 amountMinimum,
        address recipient
    ) external payable override {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc IERC721Enumerable
    function totalSupply() public pure override returns (uint256) {
        // Implementation placeholder
        return 0;
    }

    /// @inheritdoc IERC721Enumerable
    function tokenByIndex(uint256 index) public pure override returns (uint256) {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc IERC721Enumerable
    function tokenOfOwnerByIndex(address owner, uint256 index) public pure override returns (uint256) {
        // Implementation placeholder
        revert("Not implemented yet");
    }
}
