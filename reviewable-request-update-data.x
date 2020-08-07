%#include "xdr/ledger-entries-data.h"

namespace stellar
{
struct UpdateDataRequest {
    //: ID of the data entry
    uint64 id;

    AccountID owner;
    uint64 type;
    longstring value;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
}