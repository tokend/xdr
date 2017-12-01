// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Set Limits Options

    Threshold: med

    Result: SetLimitsResult
*/

struct SetLimitsOp
{
    AccountID* account;
    AccountType* accountType;

    Limits limits;
	// reserved for future use
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;
};

/******* SetLimits Result ********/

enum SetLimitsResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,
    // codes considered as "failure" for the operation
    MALFORMED = -1
};

union SetLimitsResult switch (SetLimitsResultCode code)
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
