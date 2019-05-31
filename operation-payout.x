%#include "xdr/ledger-entries.h"

namespace stellar
{

/* Payout

    Spread an amount in specific asset between all holders of base asset

    Threshold: high

    Result: PayoutResult
*/

struct PayoutOp
{
    AssetCode asset; // asset, which holders will receive dividends
    BalanceID sourceBalanceID; // balance, from which payout will be performed

    uint64 maxPayoutAmount; // max amount of asset, that owner wants to pay out
    uint64 minPayoutAmount; // min tokens amount which will be payed for one balance;
    uint64 minAssetHolderAmount; // min tokens amount for which holder will received dividends

    Fee fee;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* Payout Result ********/

enum PayoutResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,    // payout successfully completed

    // codes considered as "failure" for the operation
    INVALID_AMOUNT = -1, // max payout amount can not be zero
    INVALID_ASSET = -2,
    ASSET_NOT_FOUND = -3,
    ASSET_NOT_TRANSFERABLE = -4, // asset must have policy transferable
    BALANCE_NOT_FOUND = -5,
    INSUFFICIENT_FEE_AMOUNT = -6,
    FEE_EXCEEDS_ACTUAL_AMOUNT = -7,
    TOTAL_FEE_OVERFLOW = -8,
    UNDERFUNDED = -9, // not enough amount on source balance
    HOLDERS_NOT_FOUND = -10, // there is no holders of such asset
    MIN_AMOUNT_TOO_BIG = -11, // there is no appropriate holders balances
    LINE_FULL = -12, // destination balance amount overflows
    STATS_OVERFLOW = -13, // source statistics overflow
    LIMITS_EXCEEDED = -14, // source account limit exceeded
    INCORRECT_PRECISION = -15 // asset does not allow amounts with such precision
};

struct PayoutResponse
{
    AccountID receiverID;
    BalanceID receiverBalanceID;
    uint64 receivedAmount;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct PayoutSuccessResult
{
    PayoutResponse payoutResponses<>;
    uint64 actualPayoutAmount;
    Fee actualFee;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union PayoutResult switch (PayoutResultCode code)
{
    case SUCCESS:
        PayoutSuccessResult success;
    default:
        void;
};

}
