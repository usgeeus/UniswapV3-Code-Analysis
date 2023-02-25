//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

library Tick {
    struct Info {
        bool initialized;
        uint128 liquidity;
    }

    function update(
        mapping(int24 => Tick.Info) storage self, //storage 키워드를 통해 reference(포인터)를 받는다.
        int24 tick,
        uint128 liquidityDelta
    ) internal returns (bool flipped) {
        Tick.Info storage tickInfo = self[tick];
        uint128 liquidityBefore = tickInfo.liquidity;
        uint128 liquidityAfter = liquidityBefore + liquidityDelta;

        if (liquidityBefore == 0) {
            tickInfo.initialized = true;
        }

        tickInfo.liquidity = liquidityAfter;
        // true when liquidity is added to an empty tick or when entire liquidity is removed from a tick
        flipped = (liquidityAfter == 0) != (liquidityBefore == 0);
    }
}
