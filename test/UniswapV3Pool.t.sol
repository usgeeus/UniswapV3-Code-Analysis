// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "forge-std/Test.sol";
import "./ERC20Mintable.sol";
import "../src/UniswapV3Pool.sol";

contract UniswapV3PoolTest is Test {
    ERC20Mintable token0;
    ERC20Mintable token1;
    UniswapV3Pool pool;

    function setUp() public {
        token0 = new ERC20Mintable("Ether", "ETH", 18);
        token1 = new ERC20Mintable("USDC", "USDC", 18);
    }

    function testExample() public {
        assertTrue(true);
    }

    // function testMintSuccess() public {
    //     TestCaseParams memory params = TestCaseParams({
    //         wethBalance: 1 ether,
    //         usdcBalance: 5000 ether,
    //         currentTick: 85176,
    //         lowerTick: 84222,
    //         upperTick: 86129,
    //         liquidity: 1517882343751509868544,
    //         currentSqrtP: 5602277097478614198912276234240,
    //         shouldTransferInCallback: true,
    //         mintLiqudity: true
    //     });
    // }
}
