%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-resource-account-rule.h"

namespace stellar
{

struct AccountRuleEntry
{
    uint64 id;

    AccountRuleResource resource;
    string256 action;

    bool isForbid;

    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}