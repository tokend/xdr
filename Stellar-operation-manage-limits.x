// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-ledger-entries-limits-v2.h"

namespace stellar
{

enum ManageLimitsAction
{
    CREATE = 0,
    REMOVE = 1
};

struct LimitsCreateDetails
{
    AccountType *accountType;
    AccountID   *accountID;
    StatsOpType statsOpType;
    AssetCode   assetCode;
    bool        isConvertNeeded;

    uint64 dailyOut;
    uint64 weeklyOut;
    uint64 monthlyOut;
    uint64 annualOut;
};

/* Manage Limits Options

    Threshold: med

    Result: ManageLimitsResult
*/

struct ManageLimitsOp
{
    union switch (ManageLimitsAction action)
    {
    case CREATE:
        LimitsCreateDetails limitsCreateDetails;
    case REMOVE:
        uint64 id;
    } details;

     // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageLimits Result ********/

enum ManageLimitsResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,
    NOT_FOUND = -2,
    ALREADY_EXISTS = -3,
    CANNOT_CREATE_FOR_ACC_ID_AND_ACC_TYPE = -4, // limits cannot be created for account ID and account type simultaneously
    INVALID_LIMITS = -5
};

union ManageLimitsResult switch (ManageLimitsResultCode code)
{
case SUCCESS:
    struct {
        union switch (ManageLimitsAction action)
        {
        case CREATE:
            uint64 id;
        case REMOVE:
            void;
        } details;

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
