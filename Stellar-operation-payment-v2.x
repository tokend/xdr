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
	DESTINATION_BALANCE_NOT_FOUND = -4,
    BALANCE_ASSETS_MISMATCHED = -5,
	SRC_BALANCE_NOT_FOUND = -6, // source balance not found
    REFERENCE_DUPLICATION = -7,
    STATS_OVERFLOW = -8,
    LIMITS_EXCEEDED = -9,
    NOT_ALLOWED_BY_ASSET_POLICY = -10,
    INVALID_DESTINATION_FEE = -11,
    INVALID_DESTINATION_FEE_ASSET = -12, // destination fee asset must be the same as source balance asset
    FEE_ASSET_MISMATCHED = -13,
    INSUFFICIENT_FEE_AMOUNT = -14,
    BALANCE_TO_CHARGE_FEE_FROM_NOT_FOUND = -15,
    PAYMENT_AMOUNT_IS_LESS_THAN_DEST_FEE = -16
};

struct PaymentV2Response {
    AccountID destination;
    BalanceID destinationBalanceID;

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