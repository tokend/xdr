%#include "xdr/types.h"
%#include "xdr/operation-payment.h"

namespace stellar
{
    struct LPRemoveLiquidityOp
    {
        //: Balance of an LP token
        BalanceID lpTokenBalance;
        //: Amount of the LP tokens to be exchanged for assets pair
        uint64 lpTokensAmount;

        //: Minimal amount of first asset to be recieved
        uint64 firstAssetMinAmount;
        //: Minimal amount of second asset to be recieved
        uint64 secondAssetMinAmount;

        //: Reserved for future use
        EmptyExt ext;
    };

/******* LPRemoveLiquidity Result ********/

    enum LPRemoveLiquidityResultCode
    {
        //: LP remove liquidity was successfull
        SUCCESS = 0,

        //: LP token balance doesn't exists
        LP_TOKEN_BALANCE_NOT_FOUND = -1,
        //: Not enough LP tokens in the source account
        UNDERFUNDED = -2,
        //: After the removing liqudiity fulfillment, the destination balance will exceed the limit (total amount on the balance will be greater than UINT64_MAX)
        BALANCE_OVERFLOW = -3,
        //: Zero min amount not allowed
        INVALID_MIN_AMOUNT = -4,
        //: Liquidity pool not found
        LP_NOT_FOUND = -5
    };

    struct LPRemoveLiquiditySuccess
    {
        //: Unique identifier of the liquidity pool
        uint64 liquidityPoolID;

        //: ID of the first asset balance
        BalanceID firstAssetBalanceID;
        //: ID of the second asset balance
        BalanceID secondAssetBalanceID;
        
        //: Code of the first asset 
        AssetCode firstAsset;
        //: Code of the second asset
        AssetCode secondAsset;

        //: Amount of the first asset
        uint64 firstAssetAmount;
        //: Amount of the second asset
        uint64 secondAssetAmount;

        //: Reserved for future extension
        EmptyExt ext;
    };

    union LPRemoveLiquidityResult switch (LPRemoveLiquidityResultCode code)
    {
        case SUCCESS:
            LPRemoveLiquiditySuccess success;
        default:
            void;
    };
}
