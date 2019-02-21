

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct PreIssuanceRequest {
	AssetCode asset;
	uint64 amount;
	DecoratedSignature signature;
	string64 reference;
    longstring creatorDetails; // details set by requester

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct IssuanceRequest {
	AssetCode asset;
	uint64 amount;
	BalanceID receiver;
	longstring creatorDetails; // details of the issuance (External system id, etc.)
	Fee fee; //totalFee to be payed (calculated automatically)
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
