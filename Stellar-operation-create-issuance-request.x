// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{


/* CreateIssuanceRequestOp

    Creates or deletes issuance request

    Threshold: high

    Result: CreateIssuanceRequestResult
*/
struct CreateIssuanceRequestOp
{
	IssuanceRequest request;
	string64 reference;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateIssuanceRequest Result ********/

enum CreateIssuanceRequestResultCode
{
    // codes considered as "success" for the operation
    CREATE_ISSUANCE_REQUEST_SUCCESS = 0,

    // codes considered as "failure" for the operation
    CREATE_ISSUANCE_REQUEST_ASSET_NOT_FOUND = -1,
	CREATE_ISSUANCE_REQUEST_INVALID_AMOUNT = -2,
	CREATE_ISSUANCE_REQUEST_REFERENCE_DUPLICATION = -3,
	CREATE_ISSUANCE_REQUEST_NO_COUNTERPARTY = -4,
	CREATE_ISSUANCE_REQUEST_NOT_AUTHORIZED = -5,
	CREATE_ISSUANCE_REQUEST_EXCEEDS_MAX_ISSUANCE_AMOUNT = -6,
	CREATE_ISSUANCE_REQUEST_RECEIVER_FULL_LINE = -7
};

struct CreateIssuanceRequestSuccess {
	uint64 requestID;
	bool fulfilled;
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;
};

union CreateIssuanceRequestResult switch (CreateIssuanceRequestResultCode code)
{
case CREATE_ISSUANCE_REQUEST_SUCCESS:
    CreateIssuanceRequestSuccess success;
default:
    void;
};

}
