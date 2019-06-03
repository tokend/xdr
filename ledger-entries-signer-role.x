%#include "xdr/types.h"

namespace stellar
{

struct SignerRoleEntry
{
    uint64 id;
    uint64 ruleIDs<>;

    AccountID ownerID;

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