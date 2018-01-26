%#include "xdr/Stellar-types.h"

namespace stellar
{

enum ExternalSystemType
{
	BITCOIN = 1,
	ETHEREUM = 2,
	SECURE_VOTE = 3
};

struct ExternalSystemAccountID
{
    AccountID accountID;
    ExternalSystemType externalSystemType;
	longstring data;

	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
