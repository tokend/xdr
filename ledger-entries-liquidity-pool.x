%#include "xdr/types.h"

namespace stellar
{
    struct LPAssetPair
    {
        //: First asset of the pair
        AssetCode firstAsset;
        //: Amount of first asset
        uint64 firtsAssetAmount;
        //: Balance of first asset
        BalanceID firstAssetBalance;
        //: Second asset of the pair
        AssetCode secondAsset;
        //: Amount of second asset
        uint64 secondAssetAmount;
        //: Balance of second asset
        BalanceID secondAssetID;
    };

    struct LiquidityPoolEntry
    {
        //: Unique identifier of the liquidity pool
        uint64 sequentialID;

        //: Account that holds balances of the liquidity pool
        AccountID liquidityPoolOwner;
        //: Balance of the LP tokens
        BalanceID lpTokensBalance;

        //: Amount of LP tokens
        uint64 lpTokensAmount;

        //: Pair of assets in liquidity pool
        LPAssetPair assetPair;

        //: Reserved for future usage
        EmptyExt ext;
    };
}
