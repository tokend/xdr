// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"


namespace stellar
{

/* CreateManageLimitsRequestOp

    Create manage limits request

    Threshold: med or high

    Result: CreateManageLimitsRequestResult
*/

struct CreateManageLimitsRequestOp
{
    LimitsUpdateRequest manageLimitsRequest;

	// reserved for future use
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;

};

/******* CreateManageLimits Result ********/

enum CreateManageLimitsRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,
    // codes considered as "failure" for the operation
	MANAGE_LIMITS_REQUEST_REFERENCE_DUPLICATION = -1
};


union CreateManageLimitsRequestResult switch (CreateManageLimitsRequestResultCode code)
{
case SUCCESS:
    struct {
        uint64 manageLimitsRequestID;
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
