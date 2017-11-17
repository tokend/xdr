// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-ledger-entries-coins-emission-request.h"

namespace stellar
{

/* ReviewCoinsEmissionRequestOp

    Approves or rejects coins emission request

    Threshold: high

    Result: ReviewCoinsEmissionRequestResult
*/


struct ReviewCoinsEmissionRequestOp
{
	CoinsEmissionRequestEntry request;  // request to be reviewed
	bool approve;
	string64 reason;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ReviewCoinsEmissionRequest Result ********/

enum ReviewCoinsEmissionRequestResultCode
{
    // codes considered as "success" for the operation
    REVIEW_COINS_EMISSION_REQUEST_SUCCESS = 0,

    // codes considered as "failure" for the operation
    REVIEW_COINS_EMISSION_REQUEST_INVALID_REASON = -1,        // reason must be null if approving
	REVIEW_COINS_EMISSION_REQUEST_NOT_FOUND = -2,             // failed to find emission request with such ID
	REVIEW_COINS_EMISSION_REQUEST_NOT_EQUAL = -3,             // stored emission request is not equal to request provided in op
	REVIEW_COINS_EMISSION_REQUEST_ALREADY_REVIEWED = -4,      // emission request have been already reviewed
	REVIEW_COINS_EMISSION_REQUEST_MALFORMED = -5,             // emission request is malformed
    REVIEW_COINS_EMISSION_REQUEST_NOT_ENOUGH_PREEMISSIONS = -6,    // serial is already used in another review
	REVIEW_COINS_EMISSION_REQUEST_LINE_FULL = -9,             // balance will overflow
    REVIEW_COINS_EMISSION_REQUEST_ASSET_NOT_FOUND = -10,
    REVIEW_COINS_EMISSION_REQUEST_BALANCE_NOT_FOUND = -11,
	REVIEW_COINS_EMISSION_REQUEST_REFERENCE_DUPLICATION = -12
};

union ReviewCoinsEmissionRequestResult switch (ReviewCoinsEmissionRequestResultCode code)
{
case REVIEW_COINS_EMISSION_REQUEST_SUCCESS:
	struct {
		uint64 requestID;
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
