// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "forge-std/Test.sol";
//import "forge-std/console.sol";
import "../../src/lib/Math.sol";
import "../../src/lib/TickMath.sol";
import "../../src/lib/SwapMath.sol";
import "../../src/lib/TickBitmap.sol";

contract MathTest is Test {
    function testCalcAmount0Delta() public {
        uint256 amount0 = Math.calcAmount0Delta(
            TickMath.getSqrtRatioAtTick(85176),
            TickMath.getSqrtRatioAtTick(86129),
            1517882343751509868544
        );
        assertEq(amount0, 0.998833192822975409 ether);
    }

    function testCalcAmount1Delta() public {
        uint256 amount1 = Math.calcAmount1Delta(
            TickMath.getSqrtRatioAtTick(84222),
            TickMath.getSqrtRatioAtTick(85176),
            1517882343751509868544
        );
        assertEq(amount1, 4999.187247111820044641 ether);
    }

    function testGetSqrtRatioAtTick() public {
        uint160 sqrtPriceX96 = TickMath.getSqrtRatioAtTick(85247);
        console.log(sqrtPriceX96);
    }

    function testComputeSwapStep() public {
        (
            uint160 sqrtPriceNextX96,
            uint256 amountIn,
            uint256 amountOut
        ) = SwapMath.computeSwapStep(
                5602277097478614198912276234240,
                5622145994867546797787171334839,
                1517882343751509868544,
                42 ether
            );
        console.log(sqrtPriceNextX96, amountIn, amountOut);
    }

    function testGetTickAtSqrtRatio() public {
        int24 tick = TickMath.getTickAtSqrtRatio(
            5604469350942327889444743441197
        );
        console.log(uint256(int256(tick)));
    }

    mapping(int16 => uint256) tickBitmap;

    function testNextInitializedTickWithinOneWord() public {
        (int24 nextTick, ) = TickBitmap.nextInitializedTickWithinOneWord(
            tickBitmap,
            85176,
            1,
            false
        );
        console.log(uint24(nextTick));
    }
}
