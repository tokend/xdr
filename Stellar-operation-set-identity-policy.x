// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-ledger-entries-identity-policy.h"

namespace stellar
{
/* SetIdentityPolicyOp

 Creates, updates or deletes identity policy

 Threshold: med

 Result: SetIdentityPolicyResult
*/

struct SetIdentityPolicyData
{
    uint64 priority;
    string256 resource;
    string256 action;
    Effect effect;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct SetIdentityPolicyOp
{
    uint64 id;

    SetIdentityPolicyData *data;

	// reserved for future use
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;
};

/******* SetIdentityPolicy Result ********/

enum SetIdentityPolicyResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    POLICIES_LIMIT_EXCEED = -1, // too many policies for account
    MALFORMED = -2,
	NOT_FOUND = -3
};

union SetIdentityPolicyResult switch (SetIdentityPolicyResultCode code)
{
    case SUCCESS:
        struct {
            uint64 identityPolicyID;

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
