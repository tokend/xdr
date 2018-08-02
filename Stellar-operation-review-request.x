// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-operation-payment-v2.h"

namespace stellar
{

enum ReviewRequestOpAction {
	APPROVE = 1,
	REJECT = 2,
	PERMANENT_REJECT = 3
};

/* ReviewRequestOp

    Approves or rejects reviewable request

    Threshold: high

    Result: ReviewRequestResult
*/

struct LimitsUpdateDetails {
    LimitsV2Entry newLimitsV2;
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct WithdrawalDetails {
	string externalDetails<>;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct AMLAlertDetails {
	string comment<>;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct UpdateKYCDetails {
    uint32 tasksToAdd;
    uint32 tasksToRemove;
    string externalDetails<>;
    // Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct BillPayDetails {
    PaymentOpV2 paymentDetails;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ReviewRequestOp
{
	uint64 requestID;
	Hash requestHash;
	union switch(ReviewableRequestType requestType) {
	case WITHDRAW:
		WithdrawalDetails withdrawal;
    case LIMITS_UPDATE:
        LimitsUpdateDetails limitsUpdate;
	case TWO_STEP_WITHDRAWAL:
		WithdrawalDetails twoStepWithdrawal;
    case AML_ALERT:
        AMLAlertDetails amlAlertDetails;
    case UPDATE_KYC:
        UpdateKYCDetails updateKYC;
    case INVOICE:
        BillPayDetails billPay;
	default:
		void;
	} requestDetails;
	ReviewRequestOpAction action;
	longstring reason;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ReviewCoinsEmissionRequest Result ********/

enum ReviewRequestResultCode
{
    // Codes considered as "success" for the operation
    SUCCESS = 0,

    // Codes considered as "failure" for the operation
    INVALID_REASON = -1,        // reason must be empty if approving and not empty if rejecting
	INVALID_ACTION = -2,
	HASH_MISMATCHED = -3,
	NOT_FOUND = -4,
	TYPE_MISMATCHED = -5,
	REJECT_NOT_ALLOWED = -6, // reject not allowed, use permanent reject
	INVALID_EXTERNAL_DETAILS = -7,
	REQUESTOR_IS_BLOCKED = -8,
	PERMANENT_REJECT_NOT_ALLOWED = -9, // permanent reject not allowed, use reject

	// Asset requests
	ASSET_ALREADY_EXISTS = -20,
	ASSET_DOES_NOT_EXISTS = -21,

	// Issuance requests
	MAX_ISSUANCE_AMOUNT_EXCEEDED = -40,
	INSUFFICIENT_AVAILABLE_FOR_ISSUANCE_AMOUNT = -41,
	FULL_LINE = -42, // can't fund balance - total funds exceed UINT64_MAX

	// Sale creation requests
	BASE_ASSET_DOES_NOT_EXISTS = -50,
	HARD_CAP_WILL_EXCEED_MAX_ISSUANCE = -51,
	INSUFFICIENT_PREISSUED_FOR_HARD_CAP = -52,

	// Update KYC requests
	NON_ZERO_TASKS_TO_REMOVE_NOT_ALLOWED = -60,

	// Update sale details, end time and promotion requests
	SALE_NOT_FOUND = -70,

	// Promotion update requests
	INVALID_SALE_STATE = -80, // sale state must be "PROMOTION"

	// Update sale end time requests
    INVALID_SALE_NEW_END_TIME = -90, // new end time is before start time or current ledger close time

    // Invoice requests
    AMOUNT_MISMATCHED = -101, // amount does not match
    DESTINATION_BALANCE_MISMATCHED = -102, // invoice balance and payment balance do not match
    DESTINATION_ACCOUNT_MISMATCHED = -103, // invoice account and payment account do not match
    REQUIRED_SOURCE_PAY_FOR_DESTINATION = -104, // not allowed shift fee responsibility to destination
    SOURCE_BALANCE_MISMATCHED = -105, // source balance must match invoice sender account
    CONTRACT_NOT_FOUND = -106,
    INVOICE_RECIEVER_BALANCE_LOCK_AMOUNT_OVERFLOW = -107,
    // codes considered as "failure" for the payment operation
    PAYMENT_V2_MALFORMED = -110, // bad input, requestID must be > 0
    UNDERFUNDED = -111, // not enough funds in source account
    LINE_FULL = -112, // destination would go above their limit
    DESTINATION_BALANCE_NOT_FOUND = -113,
    BALANCE_ASSETS_MISMATCHED = -114,
    SRC_BALANCE_NOT_FOUND = -115, // source balance not found
    REFERENCE_DUPLICATION = -116,
    STATS_OVERFLOW = -117,
    LIMITS_EXCEEDED = -118,
    NOT_ALLOWED_BY_ASSET_POLICY = -119,
    INVALID_DESTINATION_FEE = -120,
    INVALID_DESTINATION_FEE_ASSET = -121, // destination fee asset must be the same as source balance asset
    FEE_ASSET_MISMATCHED = -122,
    INSUFFICIENT_FEE_AMOUNT = -123,
    BALANCE_TO_CHARGE_FEE_FROM_NOT_FOUND = -124,
    PAYMENT_AMOUNT_IS_LESS_THAN_DEST_FEE = -125
};

union ReviewRequestResult switch (ReviewRequestResultCode code)
{
case SUCCESS:
	struct {
		// reserved for future use
		union switch (LedgerVersion v)
		{
		case ADD_SALE_ID_REVIEW_REQUEST_RESULT:
		    uint64 saleID;
		case ADD_REVIEW_INVOICE_REQUEST_PAYMENT_RESPONSE:
		    PaymentV2Response paymentV2Response;
		case ADD_CONTRACT_ID_REVIEW_REQUEST_RESULT:
		    uint64 contractID;
		case EMPTY_VERSION:
			void;
		}
		ext;
	} success;
default:
    void;
};

}
