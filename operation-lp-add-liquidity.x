%#include "xdr/types.h"
%#include "xdr/operation-payment.h"

namespace stellar
{
    struct LPAddLiquidityOp
    {
        //: Balance for first asset of the pair
        BalanceID firstAssetBalanceID;
        //: Balance for second asset of the pair
        BalanceID secondAssetBalanceID;

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
        //: LP add liquidity was successful
        SUCCESS = 0,

        //: Assets in the pair are equal
        SAME_ASSETS = -1,
        //: Not enough funds in the source account
        UNDERFUNDED = -2,
        //: After adding liquidity, the destination balance will exceed the limit (total amount on the balance will be greater than UINT64_MAX)
        BALANCE_OVERFLOW = -3,
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
        //: Amount of first asset is insufficient to provide liquidity
        INSUFFICIENT_FIRST_ASSET_AMOUNT = -9,
        //: Amount of second asset is insufficient to provide liquidity
        INSUFFICIENT_SECOND_ASSET_AMOUNT = -10,
        //: Min amount cannot be bigger than desired amount
        MIN_AMOUNT_BIGGER_THAN_DESIRED = -11,
        //: Amount of the LP tokens to issue equals to zero
        INSUFFICIENT_LIQUIDITY_PROVIDED = -12,
        //: Source balances are equal
        SAME_BALANCES = -13
    };

    struct LPAddLiquiditySuccess
    {
        //: Unique identifier of the liquidity pool
        uint64 liquidityPoolID;

        //: ID of the pool account
        AccountID poolAccount;

        //: ID of the first asset balance in LP
        BalanceID lpFirstAssetBalanceID;
        //: ID of the second asset balance in LP
        BalanceID lpSecondAssetBalanceID;

        //: ID of the source first asset balance
        BalanceID sourceFirstAssetBalanceID;
        //: ID of the source second asset balance
        BalanceID sourceSecondAssetBalanceID;

        //: Amount of tokens charged from source first balance
        uint64 firstAssetAmount;
        //: Amount of tokens charged from source second balance
        uint64 secondAssetAmount;
        
        //: ID of the LP tokens asset balance 
        BalanceID lpTokensBalanceID;
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
