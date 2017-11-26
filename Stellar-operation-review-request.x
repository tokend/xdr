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


struct ReviewRequestOp
{
	uint64 requestID;
	Hash requestHash;
	ReviewableRequestType requestType;
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
    // codes considered as "success" for the operation
    REVIEW_REQUEST_SUCCESS = 0,

    // codes considered as "failure" for the operation
    REVIEW_REQUEST_INVALID_REASON = -1,        // reason must be empty if approving and not empty if rejecting
	REVIEW_REQUEST_INVALID_ACTION = -2,
	REVIEW_REQUEST_HASH_MISMATCHED = -3,
	REVIEW_REQUEST_NOT_FOUND = -4,
	REVIEW_REQUEST_TYPE_MISMATCHED = -5,
	REVIEW_REQUEST_REJECT_NOT_ALLOWED = -6, // reject not allowed, use permanent reject

	// Asset requests
	REVIEW_REQUEST_ASSET_ALREADY_EXISTS = -20,
	REVIEW_REQUEST_ASSET_DOES_NOT_EXISTS = -21,

	// Issuance requests
	REVIEW_REQUEST_MAX_ISSUANCE_AMOUNT_EXCEEDED = -40,
	REVIEW_REQUEST_INSUFFICIENT_AVAILABLE_FOR_ISSUANCE_AMOUNT = -41,
	REVIEW_REQUEST_FULL_LINE = -42 // can't fund balance - total funds exceed UINT64_MAX
	
};

union ReviewRequestResult switch (ReviewRequestResultCode code)
{
case REVIEW_REQUEST_SUCCESS:
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
