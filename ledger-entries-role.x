%#include "xdr/types.h"

namespace stellar
{

struct RoleEntry
{
    uint64 id;
    uint64 ruleIDs<>;

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