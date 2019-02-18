

%#include "xdr/Stellar-types.h"


namespace stellar
{

struct AMLAlertRequest {
    BalanceID balanceID;
    uint64 amount;
    longstring creatorDetails; // details set by requester

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
