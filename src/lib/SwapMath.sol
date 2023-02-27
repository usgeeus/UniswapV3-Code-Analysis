// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.14;

import "./Math.sol";

library SwapMath {
    function computeSwapStep(
        uint160 sqrtPriceCurrentX96,
        uint160 sqrtPriceTargetX96,
        uint128 liquidity,
        uint256 amountRemaining
    )
        internal
        pure
        returns (uint160 sqrtPriceNextX96, uint256 amountIn, uint256 amountOut)
    {
        bool zeroForOne = sqrtPriceCurrentX96 >= sqrtPriceTargetX96;

        amountIn = zeroForOne
            ? Math.calcAmount0Delta( //selling token x
                sqrtPriceCurrentX96,
                sqrtPriceTargetX96,
                liquidity
            )
            : Math.calcAmount1Delta( //selling token y
                sqrtPriceCurrentX96,
                sqrtPriceTargetX96,
                liquidity
            );

        if (amountRemaining >= amountIn) sqrtPriceNextX96 = sqrtPriceTargetX96;//current price range cannot fulfil the whole swap, thus the next sqrtPriceNextX96 is the upper/lower sqrtPriceNextX96 of the price range.(in other words, we use the entire liquidity of the price range).
        else {
            sqrtPriceNextX96 = Math.getNextSqrtPriceFromInput(
                sqrtPriceCurrentX96,
                liquidity,
                amountRemaining,
                zeroForOne
            );
        }

        amountIn = Math.calcAmount0Delta(
            sqrtPriceCurrentX96,
            sqrtPriceNextX96,
            liquidity
        );
        amountOut = Math.calcAmount1Delta(
            sqrtPriceCurrentX96,
            sqrtPriceNextX96,
            liquidity
        );

        if (!zeroForOne) {
            (amountIn, amountOut) = (amountOut, amountIn);
        }
    }
}
