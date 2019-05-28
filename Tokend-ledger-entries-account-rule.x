%#include "xdr/Tokend-types.h"
%#include "xdr/Tokend-resource-account-rule.h"

namespace stellar
{

struct AccountRuleEntry
{
    uint64 id;

    AccountRuleResource resource;
    AccountRuleAction action;

    bool forbids;

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