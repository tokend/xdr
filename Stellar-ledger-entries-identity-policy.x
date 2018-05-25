
%#include "xdr/Stellar-types.h"

namespace stellar
{

enum Effect
{
    DENY = 0,
    ALLOW = 1
};


struct IdentityPolicyEntry
{
    uint64 id;
    uint64 priority;
    string resource<>;
    string action<>;
	Effect effect;
	AccountID ownerID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}