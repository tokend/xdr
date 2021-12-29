%#include "xdr/types.h"

namespace stellar
{
    enum LPSwapType
    {
        TOKENS_FOR_EXACT_TOKENS = 0,
        EXACT_TOKENS_FOR_TOKENS = 1
    };

    struct LPSwapOp
    {
        //: Source balance of the swap
        BalanceID sourceBalance;
        //: Target balance of the swap
        BalanceID targetBalance;

        union switch(LPSwapType type)
        {
            //: Execute swap for exact output amount
            case TOKENS_FOR_EXACT_TOKENS:
                struct
                {
                    //: Maximum amount to send in the swap
                    uint64 amountInMax;
                    //: Desired amount to be recieved
                    uint64 amountOut;
                } swapTokensForExactTokens;
            //: Execute swap for exact input amount 
            case EXACT_TOKENS_FOR_TOKENS:
                struct
                {
                    //: Amount to send in the swap
                    uint64 amountIn;
                    //: Minimum amount to be recieved
                    uint64 amountOutMin;
                } swapExactTokensForTokens;
        } lpSwapRequest;

        //: Fee data for the swap
        PaymentFeeData feeData;

        //: Time till which swap can be executed
        int64 deadline;

        //: Reserved for future use
        EmptyExt ext;
    };

/******* LPSwap Result ********/

    enum LPSwapResultCode
    {
        //: LP was successfull
        SUCCESS = 0,

        //: Source and target balances are the same
        MALFORMED = -1,
        //: Not enough funds in the source account
        UNDERFUNDED = -2,
        //: Sender balance asset and receiver balance asset are not equal
        BALANCE_ASSETS_MATCHED = -3,
        //: There is no balance found with ID provided in `sourceBalance`
        SRC_BALANCE_NOT_FOUND = -4,
        //: There is no balance found with ID provided in `targetBalance`
        TGT_BALANCE_NOT_FOUND = -5,
        //: Payment asset does not have a `SWAPPABLE` policy set
        NOT_ALLOWED_BY_ASSET_POLICY = -6,
        //: Overflow during total fee calculation
        INVALID_DESTINATION_FEE = -7,
        //: Payment fee amount is insufficient
        INSUFFICIENT_FEE_AMOUNT = -8,
        //: Fee charged from destination balance is greater than the amount
        AMOUNT_IS_LESS_THAN_DEST_FEE = -9,
        //: Amount precision and asset precision are mismatched
        INCORRECT_AMOUNT_PRECISION = -10,
        //: Deadline is in the past
        SWAP_EXPIRED = -11,
        //: Zero amount is not allowed
        INVALID_AMOUNT = -12
    };

    struct LPSwapSuccess
    {
        //: Unique identifier of the liquidity pool
        uint64 liquidityPoolID;

        //: ID of the pool account
        AccountID pool;
        //: ID of the destination balance
        BalanceID destBalance;

        //: Code of the source asset used in LP swap
        AssetCode sourceAsset;
        //: Code of the target asset used in LP swap
        AssetCode targetAsset;

        //: Amount of the source asset used for swap
        uint64 swapInAmount;
        //: Amount of the target asset recieved from swap
        uint64 swapOutAmount;

        //: Fee charged from the source balance
        Fee actualSourcePaymentFee;
        //: Fee charged from the destination balance
        Fee actualDestinationPaymentFee;

        //: Reserved for future extension
        EmptyExt ext;
    };

    union LPSwapResult switch (LPSwapResultCode code)
    {
        case SUCCESS:
            LPSwapSuccess success;
        default:
            void;
    };
}
