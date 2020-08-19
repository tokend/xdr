%#include "xdr/ledger-entries-data.h"

namespace stellar
{
struct DataCreationRequest {
    //: Numeric type, used for access control
    uint64 type;

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
