%#include "xdr/ledger-entries-data.h"

namespace stellar
{
struct UpdateDataRequest {
    //: Value stored
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