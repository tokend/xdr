%#include "xdr/types.h"

namespace stellar 
{

struct LockEntry
{
    uint64 id;
    //: id of the balance where the funds are locked
    BalanceID balanceID;
    //: locked amount
    uint64 amount;
    longstring reference;
    longstring details;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}