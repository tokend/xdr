%#include "xdr/types.h"
%#include "xdr/operation-payment.h"

namespace stellar
{
    struct LPAddLiquidityOp
    {
        //: First asset of the pair
        AssetCode firstAsset;
        //: Second asset of the pair
        AssetCode secondAsset;

        //: Desired amount of first asset to be provided
        uint64 firstAssetDesiredAmount;
        //: Desired amount of second asset to be provided
        uint64 secondAssetDesiredAmount;

        //: Minimal amount of first asset to be provided
        uint64 firstAssetMinAmount;
        //: Minimal amount of second asset to be provided
        uint64 secondAssetMinAmount;

        //: Fee data for providing the liquidity
        PaymentFeeData feeData;

        //: Time till which add liquidity can be executed
        uint64 deadline;

        //: Reserved for future use
        EmptyExt ext;
    };

/******* LPAddLiquidity Result ********/

    enum LPAddLiquidityResultCode
    {
        //: LP add liquidity was successfull
        SUCCESS = 0,

        //: Assets in the pair are equal or one of the assets doesn't exists
        MALFORMED = -1,
        //: Not enough funds in the source account
        UNDERFUNDED = -2,
        //: After the adding liqudiity fulfillment, the destination balance will exceed the limit (total amount on the balance will be greater than UINT64_MAX)
        LINE_FULL = -3,
        //: Provided asset does not have a `SWAPPABLE` policy set
        NOT_ALLOWED_BY_ASSET_POLICY = -4,
        //: Overflow during total fee calculation
        INVALID_DESTINATION_FEE = -5,
        //: Providing fee amount is insufficient
        INSUFFICIENT_FEE_AMOUNT = -6,
        //: Fee charged from provider is greater than the provided liquidity amount
        PROVIDED_AMOUNT_IS_LESS_THAN_FEE = -7
    };

    struct LPAddLiquiditySuccess
    {
        //: Unique identifier of the liquidity pool
        uint64 liquidityPoolID;

        //: ID of the LP account
        AccountID lpAccountID;
        //: ID of the first asset balance
        BalanceID firstAssetBalanceID;
        //: ID of the second asset balance
        BalanceID secondAssetBalanceID;
        
        //: Code of an LP token asset 
        AssetCode lpAsset;
        //: ID of the LP token balance
        BalanceID lpTokenBalanceID;
        //: Amount of LP tokens issued for provided liquidity
        uint64 lpTokensAmount;
    };

    union LPAddLiquidityResult switch (LPAddLiquidityResultCode code)
    {
        case SUCCESS:
            LPAddLiquiditySuccess success;
        default:
            void;
    };
}
