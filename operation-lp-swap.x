%#include "xdr/types.h"
%#include "xdr/operation-payment.h"

namespace stellar
{
    enum LPSwapType
    {
        EXACT_IN_TOKENS_FOR_OUT_TOKENS = 0,
        EXACT_OUT_TOKENS_FOR_IN_TOKENS = 1
    };

    struct LPSwapOp
    {
        //: Balance of the provided asset
        BalanceID fromBalance;
        //: Balance of the desired asset
        BalanceID toBalance;

        union switch(LPSwapType type)
        {
            //: Execute swap for exact output amount
            case EXACT_OUT_TOKENS_FOR_IN_TOKENS:
                struct
                {
                    //: Maximum amount to send in the swap
                    uint64 amountInMax;
                    //: Desired amount to be received
                    uint64 amountOut;
                } swapExactOutTokensForInTokens;
            //: Execute swap for exact input amount 
            case EXACT_IN_TOKENS_FOR_OUT_TOKENS:
                struct
                {
                    //: Amount to send in the swap
                    uint64 amountIn;
                    //: Minimum amount to be received
                    uint64 amountOutMin;
                } swapExactInTokensForOutTokens;
        } lpSwapRequest;

        //: Fee data for the swap
        PaymentFeeData feeData;

        //: Reserved for future use
        EmptyExt ext;
    };

/******* LPSwap Result ********/

    enum LPSwapResultCode
    {
        //: LP swap was successful
        SUCCESS = 0,

        //: Source and target balances are the same
        SAME_BALANCES = -1,
        //: Not enough funds in the source account
        UNDERFUNDED = -2,
        //: Sender balance asset and receiver balance asset are not equal
        BALANCE_ASSETS_MATCHED = -3,
        //: There is no balance found with ID provided in `fromBalance`
        FROM_BALANCE_NOT_FOUND = -4,
        //: There is no balance found with ID provided in `toBalance`
        TO_BALANCE_NOT_FOUND = -5,
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
        //: Zero input amount not allowed
        INSUFFICIENT_INPUT_AMOUNT = -11,
        //: Output amount is less than allowed 
        INSUFFICIENT_OUTPUT_AMOUNT = -12,
        //: From and to assets are the same
        SAME_ASSETS = -13,
        //: Liquidity pool for assets from balances not found
        LIQUIDITY_POOL_NOT_FOUND = -14,
        //: Reserves of the liquidity pool are insufficient for swap
        INSUFFICIENT_LIQUIDITY = -15,
        //: Calculated input amount is greater than provided amountInMax
        EXCESSIVE_INPUT_AMOUNT = -16,
        //: The destination balance will exceed the limit (total amount on the balance will be greater than UINT64_MAX) 
        BALANCE_OVERFLOW = -17
    };

    struct LPSwapSuccess
    {
        //: Unique identifier of the liquidity pool
        uint64 liquidityPoolID;

        //: ID of the pool account
        AccountID poolAccount;

        //: ID of the in balance for LP
        BalanceID lpInBalanceID;
        //: ID of the out balance for LP
        BalanceID lpOutBalanceID;

        //: ID of the in balance for source
        BalanceID sourceInBalanceID;
        //: ID of the out balance for source
        BalanceID sourceOutBalanceID;

        //: Amount of the in asset used for swap
        uint64 swapInAmount;
        //: Amount of the out asset received from swap
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
