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

// DEPRECATED
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

struct ContractDetails {
    longstring details;

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

struct ReviewDetails {
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

struct SaleExtended {
    uint64 saleID;

    // Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ExtendedResult {
    bool fulfilled;

    union switch(ReviewableRequestType requestType) {
    case SALE:
        SaleExtended saleExtended;
    case NONE:
        void;
    } typeExt;

   // Reserved for future use
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
    case CONTRACT:
        ContractDetails contract;
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
    case ADD_TASKS_TO_REVIEWABLE_REQUEST:
        ReviewDetails reviewDetails;
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
	SYSTEM_TASKS_NOT_ALLOWED = -43,
    INCORRECT_PRECISION = -44,

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
    NOT_ALLOWED_ACCOUNT_DESTINATION = -103,
    REQUIRED_SOURCE_PAY_FOR_DESTINATION = -104, // not allowed shift fee responsibility to destination
    SOURCE_BALANCE_MISMATCHED = -105, // source balance must match invoice sender account
    CONTRACT_NOT_FOUND = -106,
    INVOICE_RECEIVER_BALANCE_LOCK_AMOUNT_OVERFLOW = -107,
    INVOICE_ALREADY_APPROVED = -108,

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
    PAYMENT_AMOUNT_IS_LESS_THAN_DEST_FEE = -125,
    DESTINATION_ACCOUNT_NOT_FOUND = -126,

    // Limits update requests
    CANNOT_CREATE_FOR_ACC_ID_AND_ACC_TYPE = 130, // limits cannot be created for account ID and account type simultaneously
    INVALID_LIMITS = 131,

    // Contract requests
    CONTRACT_DETAILS_TOO_LONG = -140 // customer details reached length limit
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
        case ADD_TASKS_TO_REVIEWABLE_REQUEST:
            ExtendedResult extendedResult;
		}
		ext;
	} success;
default:
    void;
};

}
