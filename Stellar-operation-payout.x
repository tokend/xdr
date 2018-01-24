%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Payout

    Spread an amount in specific asset between all holders of base asset

    Threshold: med

    Result: PayoutResult
*/

struct PayoutOp {
    AssetCode asset; // asset, whose holders will receive dividends
    BalanceID sourceBalanceID; // balance, from which payout will be performed
    uint64 maxPayoutAmount; // max amount of asset, that owner wants to pay out

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

enum PayoutResultCode {
    // codes considered as "success" for the operation
    SUCCESS = 0,    // payout successfully completed

    // codes considered as "failure" for the operation
    MALFORMED = -1, // bad input
    ASSET_NOT_FOUND = -2,
    BALANCE_NOT_FOUND = -3,
    BALANCE_ACCOUNT_MISMATCHED = -4,
    UNDERFUNDED = -5,
    FEE_MISMATCHED = -6,
    LIMITS_EXCEEDED = -7,
    NOT_ALLOWED_BY_ASSET_POLICY = -8,
    HOLDERS_NOT_FOUND = -9,
    STATS_OVERFLOW = -10,
    LINE_FULL = -11
};

struct PayoutResponse {
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

struct PayoutSuccessResult {
    PayoutResponse payoutResponses<>;
    uint64 actualPayoutAmount;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union PayoutResult switch (PayoutResultCode code) {
    case SUCCESS:
        PayoutSuccessResult payoutSuccessResult;
    default:
        void;
};

}