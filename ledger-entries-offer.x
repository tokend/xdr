

%#include "xdr/types.h"

namespace stellar
{

/* OfferEntry
    An offer is the building block of the offer book, they are automatically
    claimed by payments when the price set by the owner is met.

*/
struct OfferEntry
{	
    uint64 offerID;
	uint64 orderBookID;
	AccountID ownerID;
	bool isBuy;
    AssetCode base; // A
    AssetCode quote;  // B
	BalanceID baseBalance; 
	BalanceID quoteBalance;
    int64 baseAmount;
	int64 quoteAmount;
	uint64 createdAt;
	int64 fee;

    int64 percentFee;

	// price of A in terms of B
    int64 price;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
