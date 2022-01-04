%#include "xdr/types.h"

namespace stellar
{
    struct LiquidityPoolEntry
    {
        //: Unique identifier of the liquidity pool
        uint64 sequentialID;

        //: Account that holds balances of the liquidity pool
        AccountID liquidityPoolAcount;

        //: Assed code of the LP token
        AssetCode lpTokenAssetCode;

        //: Balance of first asset
        BalanceID firstAssetBalance;
        //: Balance of second asset
        BalanceID secondAssetBalance;

        //: Reserved for future usage
        EmptyExt ext;
    };
}
