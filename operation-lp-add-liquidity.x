%#include "xdr/types.h"
%#include "xdr/operation-payment.h"

namespace stellar
{
    struct LPAddLiquidityOp
    {
        //: Balance for first asset of the pair
        BalanceID firstAssetBalance;
        //: Balance for second asset of the pair
        BalanceID secondAssetBalance;

        //: Asset code of the LP token
        AssetCode lpTokenAsset;

        //: Desired amount of first asset to be provided
        uint64 firstAssetDesiredAmount;
        //: Desired amount of second asset to be provided
        uint64 secondAssetDesiredAmount;

        //: Minimal amount of first asset to be provided
        uint64 firstAssetMinAmount;
        //: Minimal amount of second asset to be provided
        uint64 secondAssetMinAmount;

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
        //: Source balance not found
        SRC_BALANCE_NOT_FOUND = -5,
        //: Zero desired amount not allowed
        INVALID_DESIRED_AMOUNT = -6,
        //: Zero min amount not allowed
        INVALID_MIN_AMOUNT = -7,
        //: Amount precision and asset precision are mismatched
        INCORRECT_AMOUNT_PRECISION = -8,
        //: Can't create liquidity pool with given LP token asset code
        INCORRECT_LP_TOKEN_CODE = -9
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
        //: Amount of LP tokens issued for provided liquidity
        uint64 lpTokensAmount;
        
        //: Reserved for future extension
        EmptyExt ext;
    };

    union LPAddLiquidityResult switch (LPAddLiquidityResultCode code)
    {
        case SUCCESS:
            LPAddLiquiditySuccess success;
        default:
            void;
    };
}
