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

	// Asset requests
	REVIEW_REQUEST_ASSET_ALREADY_EXISTS = -20,
	REVIEW_REQUEST_ASSET_DOES_NOT_EXISTS = -21
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
