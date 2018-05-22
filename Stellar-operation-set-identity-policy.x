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
struct SetIdentityPolicyOp
{
    uint64 id;
    uint64 priority;
    string resource<>;
	Effect effect;

	bool isDelete;
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
    INVALID_RESOURCE = -1,      // type is not included in the types enum
    INVALID_EFFECT = -2,
    INVALID_PRIORITY = -3,
    MALFORMED = -4,
	NOT_FOUND = -5
};

union SetIdentityPolicyResult switch (SetIdentityPolicyResultCode code)
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
