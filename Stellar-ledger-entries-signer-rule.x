%#include "xdr/Stellar-types.h"

namespace stellar
{

struct SignerRuleEntry
{
    uint64 id;

    SignerRuleResource resource;
    string256 action;

    bool isForbid;
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