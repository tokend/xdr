%#include "xdr/types.h"
%#include "xdr/resource-signer-rule.h"

namespace stellar
{

struct RuleEntry
{
    uint64 id;

    RuleResource resource;
    RuleAction action;

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