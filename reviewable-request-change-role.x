

%#include "xdr/types.h"

namespace stellar
{

struct ChangeRoleRequest
{
	AccountID destinationAccount;
	uint64 accountRoleToSet;

	// Sequence number increases when request is rejected
	uint32 sequenceNumber;

    longstring creatorDetails; // details set by requester

    // Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
