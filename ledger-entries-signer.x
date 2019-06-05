%#include "xdr/types.h"

namespace stellar
{

struct SignerEntry
{
    PublicKey pubKey;
    AccountID accountID; // account to which signer had attached

    uint32 weight; // threshold for all SignerRules equals 1000
	uint32 identity;

	longstring details;

	uint64 roleID;

	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}