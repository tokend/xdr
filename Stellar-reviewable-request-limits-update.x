

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct LimitsUpdateRequest
{
    longstring creatorDetails; // details set by requester

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}