%#include "xdr/ledger-entries-data.h"

namespace stellar
{
struct UpdateDataRequest {
    //: ID of the data entry
    uint64 id;

    //: Value stored
    longstring value;

    //: Creator of the entry
    AccountID owner;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
}