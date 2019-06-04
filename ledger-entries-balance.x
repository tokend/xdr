

%#include "xdr/types.h"

namespace stellar
{

struct BalanceEntry
{
    BalanceID balanceID;
	// sequential ID - unique identifier of the balance, used by ingesting applications to
	// identify account, while keeping size of index small 
    uint64 sequentialID;
    AssetCode asset;
    AccountID accountID;
    uint64 amount;
    uint64 locked;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
