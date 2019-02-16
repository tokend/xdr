

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct WithdrawalRequest {
	BalanceID balance; // balance id from which withdrawal will be performed
    uint64 amount; // amount to be withdrawn
    uint64 universalAmount; // amount in stats asset
	Fee fee; // expected fee to be paid
    longstring creatorDetails; // details set by requester

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
