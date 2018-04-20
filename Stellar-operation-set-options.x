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

struct LimitsUpdateRequestData {
    Hash documentHash;
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

    // Create LimitsUpdateRequest for account
    LimitsUpdateRequestData* limitsUpdateRequestData;

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
    SUCCESS = 0,
    // codes considered as "failure" for the operation
    TOO_MANY_SIGNERS = -1, // max number of signers already reached
    THRESHOLD_OUT_OF_RANGE = -2, // bad value for weight/threshold
    BAD_SIGNER = -3,             // signer cannot be masterkey
    BALANCE_NOT_FOUND = -4,
    TRUST_MALFORMED = -5,
	TRUST_TOO_MANY = -6,
	INVALID_SIGNER_VERSION = -7, // if signer version is higher than ledger version
	LIMITS_UPDATE_REQUEST_REFERENCE_DUPLICATION = -8
};

union SetOptionsResult switch (SetOptionsResultCode code)
{
case SUCCESS:
    struct {
        uint64 limitsUpdateRequestID;
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
