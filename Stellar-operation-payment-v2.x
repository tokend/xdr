%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* PaymentV2

    Send an amount in specified asset to a destination account.

    Threshold: med

    Result: PaymentResult
*/

struct FeeDataV2 {
    uint64 maxPaymentFee;
    uint64 fixedFee;

    // Cross asset fees
    AssetCode feeAsset;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct PaymentFeeDataV2 {
    FeeDataV2 sourceFee;
    FeeDataV2 destinationFee;
    bool sourcePaysForDest; // if true - source account pays fee, else destination

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

enum PaymentDestinationType {
    ACCOUNT = 0,
    BALANCE = 1
};

struct PaymentOpV2
{
    BalanceID sourceBalanceID;

    union switch (PaymentDestinationType type) {
        case ACCOUNT:
            AccountID accountID;
        case BALANCE:
            BalanceID balanceID;
    } destination;

    uint64 amount;

    PaymentFeeDataV2 feeData;

    longstring subject;
    longstring reference;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

enum PaymentV2ResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0, // payment successfully completed

    // codes considered as "failure" for the operation
    MALFORMED = -1, // bad input
    UNDERFUNDED = -2, // not enough funds in source account
    LINE_FULL = -3, // destination would go above their limit
	SOURCE_FEE_MISMATCHED = -4,
	DESTINATION_FEE_MISMATCHED = -5,
	DESTINATION_BALANCE_NOT_FOUND = -6,
    BALANCE_ASSETS_MISMATCHED = -7,
	SRC_BALANCE_NOT_FOUND = -8, // source balance not found
    REFERENCE_DUPLICATION = -9,
    STATS_OVERFLOW = -10,
    LIMITS_EXCEEDED = -11,
    NOT_ALLOWED_BY_ASSET_POLICY = -12,
    SRC_FEE_ASSET_NOT_FOUND = -13,
    SRC_FEE_BALANCE_NOT_FOUND = -14,
    INVALID_DESTINATION_FEE_ASSET = -15 // destination fee asset must be the same as source balance asset
};

struct PaymentV2Response {
    AccountID destination;
    AssetCode asset;
    uint64 sourceSentUniversal;
    uint64 paymentID;

    uint64 actualSourcePaymentFee;
    uint64 actualDestinationPaymentFee;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union PaymentV2Result switch (PaymentV2ResultCode code)
{
case SUCCESS:
    PaymentV2Response paymentV2Response;
default:
    void;
};

}