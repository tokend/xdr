// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Set Account Options

    updates "AccountEntry" fields.
    note: updating thresholds or signers requires high threshold

    Threshold: med or high

    Result: SetOptionsResult
*/

enum ManageTrustAction
{
    TRUST_ADD = 0,
    TRUST_REMOVE = 1
};


struct TrustData {
    TrustEntry trust;
    ManageTrustAction action;
	// reserved for future use
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;
};

struct SetOptionsOp
{
    // account threshold manipulation
    uint32* masterWeight; // weight of the master account
    uint32* lowThreshold;
    uint32* medThreshold;
    uint32* highThreshold;

    // Add, update or remove a signer for the account
    // signer is deleted if the weight is 0
    Signer* signer;

    TrustData* trustData;
	// reserved for future use
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;
    
};

/******* SetOptions Result ********/

enum SetOptionsResultCode
{
    // codes considered as "success" for the operation
    SET_OPTIONS_SUCCESS = 0,
    // codes considered as "failure" for the operation
    SET_OPTIONS_TOO_MANY_SIGNERS = -1, // max number of signers already reached
    SET_OPTIONS_THRESHOLD_OUT_OF_RANGE = -2, // bad value for weight/threshold
    SET_OPTIONS_BAD_SIGNER = -3,             // signer cannot be masterkey
    SET_OPTIONS_BALANCE_NOT_FOUND = -4,
    SET_OPTIONS_TRUST_MALFORMED = -5,
	SET_OPTIONS_TRUST_TOO_MANY = -6,
	SET_OPTIONS_INVALID_SIGNER_VERSION = -7 // if signer version is higher than ledger version
};

union SetOptionsResult switch (SetOptionsResultCode code)
{
case SET_OPTIONS_SUCCESS:
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
