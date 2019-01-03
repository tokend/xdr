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

struct ASwapBidExtended
{
    uint64 bidID;

    // Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ASwapExtended
{
    uint64 bidID;
    AccountID bidOwnerID;
    AccountID purchaserID;
    AssetCode baseAsset;
    AssetCode quoteAsset;
    uint64 baseAmount;
    uint64 quoteAmount;
    uint64 price;
    BalanceID bidOwnerBaseBalanceID;
    BalanceID purchaserBaseBalanceID;

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
	case CREATE_ATOMIC_SWAP_BID:
        ASwapBidExtended aSwapBidExtended;
    case ATOMIC_SWAP:
        ASwapExtended aSwapExtended;
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
	
    ReviewDetails reviewDetails;
    
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

	REMOVING_NOT_SET_TASKS = -100,// cannot remove tasks which are not set

	// Asset requests
	ASSET_ALREADY_EXISTS = -200,
	ASSET_DOES_NOT_EXISTS = -210,

	// Issuance requests
	MAX_ISSUANCE_AMOUNT_EXCEEDED = -400,
	INSUFFICIENT_AVAILABLE_FOR_ISSUANCE_AMOUNT = -410,
	FULL_LINE = -420, // can't fund balance - total funds exceed UINT64_MAX
	SYSTEM_TASKS_NOT_ALLOWED = -430,
    INCORRECT_PRECISION = -440,

	// Sale creation requests
	BASE_ASSET_DOES_NOT_EXISTS = -500,
	HARD_CAP_WILL_EXCEED_MAX_ISSUANCE = -510,
	INSUFFICIENT_PREISSUED_FOR_HARD_CAP = -520,
	BASE_ASSET_NOT_FOUND = -530,
	QUOTE_ASSET_NOT_FOUND = -550,

	// Update KYC requests
	NON_ZERO_TASKS_TO_REMOVE_NOT_ALLOWED = -600,

	// Update sale details
	SALE_NOT_FOUND = -700,

    // Invoice requests
    AMOUNT_MISMATCHED = -1010, // amount does not match
    DESTINATION_BALANCE_MISMATCHED = -1020, // invoice balance and payment balance do not match
    NOT_ALLOWED_ACCOUNT_DESTINATION = -1030,
    REQUIRED_SOURCE_PAY_FOR_DESTINATION = -1040, // not allowed shift fee responsibility to destination
    SOURCE_BALANCE_MISMATCHED = -1050, // source balance must match invoice sender account
    CONTRACT_NOT_FOUND = -1060,
    INVOICE_RECEIVER_BALANCE_LOCK_AMOUNT_OVERFLOW = -1070,
    INVOICE_ALREADY_APPROVED = -1080,

    // codes considered as "failure" for the payment operation
    PAYMENT_V2_MALFORMED = -1100, // bad input0, requestID must be > 0
    UNDERFUNDED = -1110, // not enough funds in source account
    LINE_FULL = -1120, // destination would go above their limit
    DESTINATION_BALANCE_NOT_FOUND = -1130,
    BALANCE_ASSETS_MISMATCHED = -1140,
    SRC_BALANCE_NOT_FOUND = -1150, // source balance not found
    REFERENCE_DUPLICATION = -1160,
    STATS_OVERFLOW = -1170,
    LIMITS_EXCEEDED = -1180,
    NOT_ALLOWED_BY_ASSET_POLICY = -1190,
    INVALID_DESTINATION_FEE = -1200,
    INVALID_DESTINATION_FEE_ASSET = -1210, // destination fee asset must be the same as source balance asset
    FEE_ASSET_MISMATCHED = -1220,
    INSUFFICIENT_FEE_AMOUNT = -1230,
    BALANCE_TO_CHARGE_FEE_FROM_NOT_FOUND = -1240,
    PAYMENT_AMOUNT_IS_LESS_THAN_DEST_FEE = -1250,
    DESTINATION_ACCOUNT_NOT_FOUND = -1260,

    // Limits update requests
    CANNOT_CREATE_FOR_ACC_ID_AND_ACC_TYPE = 1300, // limits cannot be created for account ID and account type simultaneously
    INVALID_LIMITS = 1310,

    // Contract requests
    CONTRACT_DETAILS_TOO_LONG = -1400, // customer details reached length limit

	// Atomic swap
	BASE_ASSET_CANNOT_BE_SWAPPED = -1500,
	QUOTE_ASSET_CANNOT_BE_SWAPPED = -1501,
	ASSETS_ARE_EQUAL = -1502,
	ASWAP_BID_UNDERFUNDED = -1503,
	ASWAP_PURCHASER_FULL_LINE = -1504

};

union ReviewRequestResult switch (ReviewRequestResultCode code)
{
case SUCCESS:
	ExtendedResult success;
default:
    void;
};

}
