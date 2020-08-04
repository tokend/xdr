%#include "xdr/ledger-entries-data.h"

namespace stellar
{
struct RemoveDataRequest {
    //: ID of the data entry
    uint64 id;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
}