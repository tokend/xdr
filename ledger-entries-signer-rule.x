%#include "xdr/types.h"
%#include "xdr/resource-signer-rule.h"

namespace stellar
{

struct SignerRuleEntry
{
    uint64 id;

    SignerRuleResource resource;
    SignerRuleAction action;

    bool forbids;
    bool isDefault; // default rules will be in each role

    longstring details;

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