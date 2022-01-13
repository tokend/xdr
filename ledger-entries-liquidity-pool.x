%#include "xdr/types.h"

namespace stellar
{
    struct LiquidityPoolEntry
    {
        //: Unique sequential identifier of the liquidity pool
        uint64 id;

        //: Account that holds balances of the liquidity pool
        AccountID liquidityPoolAcount;

        //: Assed code of the LP token
        AssetCode lpTokenAssetCode;

        //: Balance of first asset
        BalanceID firstAssetBalance;
        //: Balance of second asset
        BalanceID secondAssetBalance;

        //: Total amount of all LP tokens
        uint64 lpTokensTotalCap;

        //: Reserved for future usage
        EmptyExt ext;
    };
}
