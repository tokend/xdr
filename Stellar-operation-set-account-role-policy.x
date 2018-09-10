// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-ledger-entries-account-role-policy.h"

namespace stellar
{
/* SetAccountRolePolicyOp

 Creates, updates or deletes account role policy

 Threshold: med

 Result: SetAccountRolePolicyResult
*/

struct SetAccountRolePolicyData
{
    uint64 priority;
    string256 resource;
    string256 action;
    AccountRolePolicyEffect effect;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct SetAccountRolePolicyOp
{
    uint64 id;

    SetAccountRolePolicyData *data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* SetAccountRolePolicy Result ********/

enum SetAccountRolePolicyResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,
    NOT_FOUND = -2
};

union SetAccountRolePolicyResult switch (SetAccountRolePolicyResultCode code)
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
