%#include "xdr/types.h"
%#include "xdr/operation-payment.h"

namespace stellar
{
    struct LPRemoveLiquidityOp
    {
        //: Code of an LP token asset
        AssetCode lpTokenAsset;
        //: Amount of the LP tokens to be exchanged for assets pair
        uint64 lpTokensAmount;

        //: Minimal amount of first asset to be recieved
        uint64 firstAssetMinAmount;
        //: Minimal amount of second asset to be recieved
        uint64 secondAssetMinAmount;

        //: Fee data for removing the liquidity
        PaymentFeeData feeData;

        //: Time till which remove liquidity can be executed
        uint64 deadline;

        //: Reserved for future use
        EmptyExt ext;
    };

/******* LPRemoveLiquidity Result ********/

    enum LPRemoveLiquidityResultCode
    {
        //: LP remove liquidity was successfull
        SUCCESS = 0,

        //: LP token doesn't exists
        MALFORMED = -1,
        //: Not enough LP tokens in the source account
        UNDERFUNDED = -2,
        //: After the removing liqudiity fulfillment, the destination balance will exceed the limit (total amount on the balance will be greater than UINT64_MAX)
        LINE_FULL = -3,
        //: Overflow during total fee calculation
        INVALID_DESTINATION_FEE = -5,
        //: Providing fee amount is insufficient
        INSUFFICIENT_FEE_AMOUNT = -6,
        //: Fee charged is greater than the recieved asset amount
        RECIEVED_AMOUNT_IS_LESS_THAN_FEE = -7
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
    };

    union LPRemoveLiquidityResult switch (LPRemoveLiquidityResultCode code)
    {
        case SUCCESS:
            LPRemoveLiquiditySuccess success;
        default:
            void;
    };
}
