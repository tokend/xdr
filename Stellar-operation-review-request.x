// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

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
    Limits newLimits;
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
	default:
		void;
	} requestDetails;
	ReviewRequestOpAction action;
	string256 reason;
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
	NON_ZERO_TASKS_TO_REMOVE_NOT_ALLOWED = -60
};

union ReviewRequestResult switch (ReviewRequestResultCode code)
{
case SUCCESS:
	struct {
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
