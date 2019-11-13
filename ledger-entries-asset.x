

%#include "xdr/types.h"

namespace stellar
{

struct AssetEntry
{
    AssetCode code;

    uint32 securityType; // use instead policies that limit usage, use in account rules
    uint32 state; // smth that can be used to disable asset
	
	uint64 maxIssuanceAmount; // max number of tokens to be issued
	uint64 issued; // number of issued tokens
	uint64 pendingIssuance; // number of tokens to be issued
	
    uint32 trailingDigitsCount;
    
    AccountID owner;
	longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
