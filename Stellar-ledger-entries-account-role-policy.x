
%#include "xdr/Stellar-types.h"

namespace stellar
{

enum AccountRolePolicyEffect
{
    DENY = 0,
    ALLOW = 1
};

struct AccountRolePolicyEntry
{
    uint64 id;
    string resource<>;
    string action<>;
    AccountRolePolicyEffect effect;
    AccountID ownerID;
    uint64 accountRoleID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}