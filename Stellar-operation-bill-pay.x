%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-operation-payment-v2.h"

namespace stellar
{

/* BillPay

    Send an exact amount in specified asset to a destination account for existing invoice.

    Threshold: med

    Result: BillPayResult
*/

struct BillPayOp
{
    PaymentOpV2 paymentDetails;
    uint64 requestID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

enum BillPayResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0, // payment successfully completed

    // codes considered as "failure" for the payment operation
    MALFORMED = -1, // bad input, requestID must be > 0
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
    PAYMENT_AMOUNT_IS_LESS_THAN_DEST_FEE = -16,

    // codes considered as "failure" for the bill pay operation
    INVOICE_REQUEST_NOT_FOUND = -41, // cannot found invoice request
    AMOUNT_MISMATCHED = -42, // amount does not match
    DESTINATION_BALANCE_MISMATCHED = -43, // invoice balance and payment balance do not match
    DESTINATION_ACCOUNT_MISMATCHED = -44, // invoice account and payment account do not match
    REQUIRED_SOURCE_PAY_FOR_DESTINATION = -45 // not allowed shift fee responsibility to destination
};

union BillPayResult switch (BillPayResultCode code)
{
case SUCCESS:
	struct {
	    PaymentV2Response paymentV2Response;
		// reserved for future use
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
	} success;
default:
    void;
};

}