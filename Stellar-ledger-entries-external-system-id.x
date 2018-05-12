%#include "xdr/Stellar-types.h"

namespace stellar
{

struct ExternalSystemAccountID
{
    AccountID accountID;
    int32 externalSystemType;
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
